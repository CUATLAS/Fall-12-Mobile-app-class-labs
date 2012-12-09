//
//  MADViewController.m
//  Media
//
//  Created by Jenna Raderstrong on 12/9/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController (){
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
	
	actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
	
	[actionSheet showInView:self.view];
}

- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender {
}

#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	if ([buttonTitle isEqualToString:@"Save"])
	{
		if (image)
		{
			//saves the image to the camera roll
			UIImageWriteToSavedPhotosAlbum(image,
										   self,
										   @selector(image:didFinishSavingWithError:contextInfo:),
										   nil);
		}
        else if (videoURL)
		{
            //convert URL to a string
            NSString *urlString = [videoURL path];
			//checks that the device can save video to the camera roll as not all devices can
			if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlString))
			{
				//save video to the camera roll
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
		imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeSavedPhotosAlbum];
		imagePickerController.allowsEditing=NO;
		imagePickerController.delegate = self;
		[self presentModalViewController:imagePickerController animated:YES];
	}
	else if ([buttonTitle isEqualToString:@"Play Audio"])
	{
		//use NSBundle to get the file path
		NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"callmemaybe" ofType:@"m4r"];
		//build an URL object
		NSURL *fileURL = [NSURL URLWithString:soundFilePath];
		
		//initialize the player with the file URL
		audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
		//set delegate so you can know when the sound clip is done
		audioPlayer.delegate = self;
		//play the sound file
		[audioPlayer play];
	}
}

#pragma mark Photo Album saving callbacks

//called when the save operation has completed
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
		NSLog(@"Error! %@", [error localizedDescription]);
    }
    else
    {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Image saved"
															message:@"Image saved successfully to camera roll."
														   delegate:nil
												  cancelButtonTitle:nil
												  otherButtonTitles:@"OK", nil];
		[alertView show];
    }
}

//called when the save operation has completed
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
		NSLog(@"Error! %@", [error localizedDescription]);
    }
    else
    {
		UIAlertView *alertView = [[UIAlertView alloc]
								  initWithTitle:@"Video saved"
								  message:@"Video saved successfully to camera roll."
								  delegate:nil
								  cancelButtonTitle:nil
								  otherButtonTitles:@"OK", nil];
		[alertView show];
    }
}

#pragma mark UIImagePickerControllerDelegate methods

//called after successfully taking a picture or video
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	//determines whether it was a picture or a video
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
	image = nil;
	imageView.image = nil;
    videoURL=nil;
	
	if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) //picture
	{
		//the original, unmodified image from the camera
		UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
		//the final, edited image if editing was enabled.
		UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
		
		image = editedImage ? editedImage : originalImage;
		imageView.image = image;
	}
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) //video
	{
		//the URL to the video location on disk
		videoURL= [info objectForKey:UIImagePickerControllerMediaURL];
	}
	[self dismissModalViewControllerAnimated:YES]; //dismiss the camera modal view
}

//called when the user taps the cancel button in the camera view
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark AVAudioPlayerDelegate methods

//called when the audio file finishes playing
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	audioPlayer = nil;
}

//called if an error ocurred decoding the audio file
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
	audioPlayer = nil;
}



@end










