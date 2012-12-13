//
//  ViewController.m
//  Media
//
//  Created by Stephen Feuerstein on 11/27/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImage *image;
    NSURL *videoURL;
    //AVAudioPlayer *audioPlayer;
}

@end

@implementation ViewController
@synthesize imageView;
@synthesize audioPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        // Set source type to camera
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie, nil];
        // Show the picker controller
        [self presentModalViewController:imagePickerController animated:YES];
    }
    else
        NSLog(@"Error trying to access camera");
}

- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender
{
    // Create an action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
    
    // If adding a new image or video
    if (image || videoURL)
    {
        [actionSheet addButtonWithTitle:@"Save"];
    }
    [actionSheet addButtonWithTitle:@"Camera Roll"];
    [actionSheet addButtonWithTitle:@"Play Audio"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
	
	[actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate stuff

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Get the button title
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Save"])
    {
        // If it's an image
        if (image)
        {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        
        else if (videoURL)
        {
            NSString *urlString = [videoURL path];
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlString))
            {
                UISaveVideoAtPathToSavedPhotosAlbum(urlString, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        }
    }
    
    else if ([buttonTitle isEqualToString:@"Camera Roll"])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
		imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeSavedPhotosAlbum];
		imagePickerController.allowsEditing=NO;
		imagePickerController.delegate = self;
		[self presentModalViewController:imagePickerController animated:YES];
    }
    
    else if ([buttonTitle isEqualToString:@"Play Audio"])
    {
        // Get path of sound file
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"callmemaybe" ofType:@"m4a"];
        NSURL *fileURL = [NSURL URLWithString:soundFilePath];
        NSLog(@"%@", soundFilePath);
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        if (!self.audioPlayer)
            NSLog(@"audioPlayer error");
        self.audioPlayer.delegate = self;
        self.audioPlayer.volume = 1.0;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
}

#pragma mark Photo Album saving
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
        NSLog(@"Error: %@", [error localizedDescription]);
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Saved!" message:@"Image Saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
        NSLog(@"Error: %@", [error localizedDescription]);
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Saved!" message:@"Video Saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark UIImagePickerControllerDelegate stuff

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    // Init everything to nil
    image = nil;
    imageView.image = nil;
    videoURL = nil;
    
    // If image
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        // Choose the correct image if edited or not
        image = editedImage ? editedImage : originalImage;
        imageView.image = image;
    }
    
    // If video
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
	{
		//the URL to the video location on disk
		videoURL= [info objectForKey:UIImagePickerControllerMediaURL];
	}
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark AVAudioPlayerDelegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	audioPlayer = nil;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Error occurred with audio player");
	audioPlayer = nil;
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
