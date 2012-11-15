//
//  MADViewController.h
//  Animation
//
//  Created by Jenna Raderstrong on 11/15/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)sliderMoved:(UISlider *)sender;

@end
