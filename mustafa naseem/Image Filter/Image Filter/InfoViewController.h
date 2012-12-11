//
//  InfoViewController.h
//  Image Filter
//
//  Created by  on 12/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"

@interface InfoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate >
- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)changeValue:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *amountSlider;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (strong, nonatomic) Image *userInfo;

@end
