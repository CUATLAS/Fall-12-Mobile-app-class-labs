//
//  MADViewController.h
//  beatles_dani
//
//  Created by new user on 9/17/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *beatlesImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)changeImage:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl;
@property (weak, nonatomic) IBOutlet UISwitch *capitalizedSwitch;
- (IBAction)updateFont:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeNumberLabel;
- (IBAction)changeFontSize:(UISlider *)sender;

@end
