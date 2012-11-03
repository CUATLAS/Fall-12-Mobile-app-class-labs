//
//  MADViewController.h
//  Beatles
//
//  Created by Elise J Beall on 9/25/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *beatlesImage;
- (IBAction)changeFontSize:(UISlider *)sender;
- (IBAction)updateFont:(UISwitch *)sender;
- (IBAction)changeImage:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeNumberLabel;
@property (weak, nonatomic) IBOutlet UISwitch *capitalizeSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end
