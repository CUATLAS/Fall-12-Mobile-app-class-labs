//
//  MADViewController.m
//  Media
//
//  Created by  on 11/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController () {
    UIImage *image;
    NSURL *videoURL;
    AVAudioPlayer *audioPlayer;
}

@end

@implementation MADViewController
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender {
    //Checks the device to make sure it has a camera
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            //Initializes the controller
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            //Sets the delegate so it can ind out when the picture is ready
            imagePickerController.delegate = self;
            //Use the camera interface
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //Display camera roll
            imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, (NSString *)kUTTypeMovie, nil];
            //Slide up the camera interface as a modal view
            [self presentModalViewController:imagePickerController animated:YES];
        }
        else 
        {
            NSLog(@"Can't access the camera");
        }
}

- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    if (image || videoURL)
    {
        [actionSheet addButtonWithTitle:@"Save"];
    }
    [actionSheet addButtonWithTitle:@"Camera Roll"];
    [actionSheet addButtonWithTitle:@"Play Audio"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons -1;
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Save"])
    {
        if (image)
        {
            //Saves the image to the camera roll
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:didFinishSavingWithError:contextInfo:), 
                                           nil);
        }
        else if (videoURL)
        {
            //Convert URL to a string
            NSString *urlString = [videoURL path];
            
            //Checks that the device can save video to the camera roll as not all devices can
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlString))
            {
                //Save video to the cmera roll
                UISaveVideoAtPathToSavedPhotosAlbum(urlString,
                                                    self,
                                                    @selector(video:didFinishSavingWithError:contextInfo:),
                                                    nil);
            }
        }
    }
    else if ([buttonTitle isEqualToString:@"Camera Roll"])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        imagePickerController.allowsEditing = NO;
        imagePickerController.delegate = self;
        [self presentModalViewController:imagePickerController animated:YES];
    }
    else if ([buttonTitle isEqualToString:@"play Audio"])
    {
        //Use NSBundle to get the file path
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"callmemaybe" ofType:@"m4r"];
        //Build a URL object
        NSURL *fileURL = [NSURL URLWithString:soundFilePath];
        
        //Initialize the player with file URL
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
        //Set delegate so you can know the sound clip is done
        audioPlayer.delegate = self;
        //Play the sound file
        [audioPlayer play];
    }
}

#pragma mark Photo Album saving callbacks

//Called when the save operation has completed
-(void)image: (UIImage *)imageDidFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
{
    if (error)
    {
        NSLog(@"Error! %@", [error localizedDescription]);
    }
    else 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Image Saved"
                                                            message:@"Image Saved"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Ok", nil];
        [alertView show];
    }
}

//Called when the save operation has completed
-(void)video: (UIImage *)videoimageDidFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
{
    if (error)
    {
        NSLog(@"Error! %@", [error localizedDescription]);
    }
    else 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Image Saved"
                                                            message:@"Image Saved"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Ok", nil];
        [alertView show];
    }
}


#pragma mark UIImagePickerControllerDelegate methods

//Called after successfully taking a picture or video
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Determines whether it was a picture or video
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    image = nil;
    imageView.image = nil;
    videoURL = nil;
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) //Picture
    {
        //The original, unmodified image from the camera
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //The final, edited image if editing was enabled
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        image = editedImage ? editedImage :originalImage;
        imageView.image = image;
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) //Video
    {
        //The url to the video location on disk
        videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    }
    [self dismissModalViewControllerAnimated:YES]; //Dismiss the camera modal view
}

//Called when user taps the cancel button in the camera view
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark AVAudioPlayerDelegate methods

//Called when the audio file finishes playing
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    audioPlayer = nil;
}

//Called if an error occurred decoding the audio file
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    audioPlayer = nil;
}
@end
