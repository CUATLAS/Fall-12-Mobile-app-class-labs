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




- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
NSString *buttonTitle = [actionSheet
buttonTitleAtIndex:buttonIndex];
if ([buttonTitle isEqualToString:@"Save"])
{
if (image)
{
//saves the image to the camera roll
UIImageWriteToSavedPhotosAlbum(image, self,
@selector(image:didFinishSavingWithError:contextInfo:), nil);
}
}
else if ([buttonTitle isEqualToString:@"Camera Roll"])
{
UIImagePickerController *imagePickerController =
[[UIImagePickerController alloc] init];
imagePickerController.sourceType =
UIImagePickerControllerSourceTypeSavedPhotosAlbum;
imagePickerController.mediaTypes = [UIImagePickerController
availableMediaTypesForSourceType:
UIImagePickerControllerSourceTypeSavedPhotosAlbum];
imagePickerController.allowsEditing=NO;
imagePickerController.delegate = self;
[self presentModalViewController:imagePickerController
animated:YES];
}
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError
*)error contextInfo:(void *)contextInfo
{
if (error)
{
NSLog(@"Error! %@", [error localizedDescription]);
}
else
{
UIAlertView *alertView = [[UIAlertView alloc]
initWithTitle:@"Image saved"
message:@"Image saved successfully to camera roll."
delegate:nil
cancelButtonTitle:nil
otherButtonTitles:@"OK", nil];
[alertView show];
}
}
    
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //determines whether it was a picture or a video
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    image = nil;
    imageView.image = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])

{
//the original, unmodified image from the camera
UIImage *originalImage = [info
objectForKey:UIImagePickerControllerOriginalImage];
//the final, edited image if editing was enabled.
UIImage *editedImage = [info
objectForKey:UIImagePickerControllerEditedImage];
image = editedImage ? editedImage : originalImage;
imageView.image = image;
}
[self dismissModalViewControllerAnimated:YES]; 
}
//called when the user taps the cancel button in the camera view
- (void)imagePickerControllerDidCancel:(UIImagePickerController
*)picker
{
[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)actionButtonTapped:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    if (image)
    {
        [actionSheet addButtonWithTitle:@"Save"];
    }
    [actionSheet addButtonWithTitle:@"Camera Roll"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.cancelButtonIndex=actionSheet.numberOfButtons - 1;
    [actionSheet showInView:self.view];
}

- (IBAction)cameraButtonTapped:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIImagePickerController *imagePickerController =[[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType =UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        [self presentModalViewController:imagePickerController animated:YES];
    }
    else
    {
        NSLog(@"Can't access the camera");
    }
}
@end










