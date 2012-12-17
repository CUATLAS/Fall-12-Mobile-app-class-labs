//
//  MADViewController.h
//  Media
//
//  Created by Jenna Raderstrong on 12/9/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileCoreServices/MobileCoreServices.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVFoundation.h"

@interface MADViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender;



@end
