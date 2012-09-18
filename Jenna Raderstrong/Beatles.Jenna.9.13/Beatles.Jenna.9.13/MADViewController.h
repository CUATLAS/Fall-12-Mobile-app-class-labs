//
//  MADViewController.h
//  Beatles.Jenna.9.13
//
//  Created by Jenna Raderstrong on 9/13/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *beatlesimage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)changeImage:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl;
@property (weak, nonatomic) IBOutlet UISwitch *capitalizeSwitch;
- (IBAction)updateFont:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeNumberLabel;
- (IBAction)changeFontSize:(UISlider *)sender;

@end
