//
//  MADViewController.m
//  Media
//
//  Created by Aaron Vimont on 11/27/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
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
    // check the device to make sure it has a camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // initialize the controller
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        // set the delegate so it can find out when the picture is ready
        imagePickerController.delegate = self;
        // use the camera interface
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // display the camera
        imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, (NSString *) kUTTypeMovie, nil];
        // slide up camera interface as a modal view
        [self presentModalViewController:imagePickerController animated:YES];
    }
    else {
        NSLog(@"Cannot access the camera!!");
    }
}

- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    if (image || videoURL) {
        [actionSheet addButtonWithTitle:@"Save"];
    }
    [actionSheet addButtonWithTitle:@"Camera Roll"];
    [actionSheet addButtonWithTitle:@"Play Best Song Ever"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Save"]) {
        if (image) {
            // saves the image to camera roll
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        else if (videoURL) {
            // convert URL to string
            NSString *urlString = [videoURL path];
            
            // check that the device can save video to the camera roll
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlString)) {
                // save video to camera roll
                UISaveVideoAtPathToSavedPhotosAlbum(urlString, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        }
    }
    else if ([buttonTitle isEqualToString:@"Camera Roll"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        imagePickerController.allowsEditing = NO;
        imagePickerController.delegate = self;
        
        [self presentModalViewController:imagePickerController animated:YES];
    }
    else if ([buttonTitle isEqualToString:@"Play Best Song Ever"]) {
        // use NSBundle to get file path
        NSString *songFilePath = [[NSBundle mainBundle] pathForResource:@"callmemaybe" ofType:@"m4r"];
        // build URL object
        NSURL *fileURL = [NSURL URLWithString:songFilePath];
        
        // initialize the player with the file URL
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
        // set delegate so you know when sound clip is done
        audioPlayer.delegate = self;
        
        // play the sound file
        [audioPlayer play];
    }
}

#pragma mark - Photo Album saving callbacks

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Image Saved"
                                                            message:@"Image successfully saved to camera roll"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

- (void)video:(NSString *)video didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Video Saved"
                                                            message:@"Video successfully saved to camera roll"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // determines whether it was a picture or video
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    image = nil;
    imageView.image = nil;
    videoURL = nil;
    
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage]) {
        // the orginal, unmodified image from the camera
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // the final edited image if editing was enabled
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        image = editedImage ? editedImage : originalImage;
        imageView.image = image;
    }
    else if ([mediaType isEqualToString:(NSString *) kUTTypeMovie]) {
        // the URL to the video location on disk
        videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - AVAudioPlayerDelegate Methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    audioPlayer = nil;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    audioPlayer = nil;
}

@end
