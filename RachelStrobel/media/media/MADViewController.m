//
//  MADViewController.m
//  media
//
//  Created by Rachel Strobel on 11/27/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
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

/* opening image was taken and modified from: http://edudemic.com/wp-content/uploads/2012/05/istock_000011798858xsmall2.jpg*/

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

- (IBAction)camerButtonTapped:(UIBarButtonItem *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]
                                                          init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)
                                            kUTTypeImage, (NSString *) kUTTypeMovie, nil];
        
        [self presentModalViewController:imagePickerController animated:YES];
    
    }
    else
    {
        NSLog(@"Can't access the camer");
    }
}

- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate: self
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
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:didFinishSavingWithError:
                                                     contextInfo:),
                                           nil);
        }
        else if (videoURL)
        {
            NSString *urlString = [videoURL path];
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlString))
            {
                UISaveVideoAtPathToSavedPhotosAlbum(urlString, self, @selector (video:didFinishSavingWithError:contextInfo:),
                                                    nil);
            }
            
        }
    }
else if ([buttonTitle isEqualToString:@"Camera Roll"])
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]
                                                      init];
    imagePickerController.sourceType =
    UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                        UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    imagePickerController.allowsEditing=NO;
    imagePickerController.delegate = self;
    [self presentModalViewController:imagePickerController animated:YES];
    
}

else if ([buttonTitle isEqualToString:@"Play Audio"])
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"callmemaybe" ofType:@"m4r"];
    NSURL *fileURL = [NSURL URLWithString:soundFilePath];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    audioPlayer.delegate = self;
    [audioPlayer play];
}
    
}

#pragma mark Photo Album saving callbacks

-(void) image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
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

#pragma mark UIImagePickerControllerDelegate methods

-(void) imagePickerController: (UIImagePickerController *) picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    image = nil;
    imageView.image = nil;
    videoURL=nil;
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *editedImage = [info objectForKey: UIImagePickerControllerEditedImage];
        
        image = editedImage ? editedImage : originalImage;
        imageView.image = image;
    
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        videoURL= [info objectForKey:UIImagePickerControllerMediaURL];
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
