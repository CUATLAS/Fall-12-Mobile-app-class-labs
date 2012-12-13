//
//  ViewController.h
//  Media
//
//  Created by Stephen Feuerstein on 11/27/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileCoreServices/MobileCoreServices.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVFoundation.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (IBAction)cameraButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender;

@end
