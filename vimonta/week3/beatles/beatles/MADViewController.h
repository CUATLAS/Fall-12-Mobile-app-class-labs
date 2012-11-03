//
//  MADViewController.h
//  beatles
//
//  Created by Aaron Vimont on 9/13/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *beatlesImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl;
@property (weak, nonatomic) IBOutlet UISwitch *capitalizedSwitch;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeNumberLabel;
- (IBAction)changeImage:(UISegmentedControl *)sender;
- (IBAction)updateFont:(UISwitch *)sender;
- (IBAction)changeFontSize:(UISlider *)sender;

@end
