//
//  MADViewController.h
//  beatles
//
//  Created by Elise J Beall on 9/13/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beatlesImage;
- (IBAction)changeImage:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl;
@property (weak, nonatomic) IBOutlet UISwitch *capitalizeSwitch;
- (IBAction)updateFont:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeNumberLabel;
- (IBAction)changeFontSize:(UISlider *)sender;

@end
