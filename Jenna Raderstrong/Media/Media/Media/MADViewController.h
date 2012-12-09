//
//  MADViewController.h
//  Media
//
//  Created by Jenna Raderstrong on 12/9/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MADViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)actionButtonTapped:(id)sender;
- (IBAction)cameraButtonTapped:(id)sender;


@end
