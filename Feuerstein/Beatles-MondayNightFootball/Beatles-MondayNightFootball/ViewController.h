
//
//  ViewController.h
//  Beatles-MondayNightFootball
//
//  Created by Stephen Feuerstein on 9/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)teamControlValueChanged:(UISegmentedControl *)sender;
- (IBAction)capsSwitchedChanged:(UISwitch *)sender;
- (IBAction)fontSizeChanged:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *broncosImage;
@property (weak, nonatomic) IBOutlet UIImageView *falconsImage;
@property (weak, nonatomic) IBOutlet UILabel *vsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fontLabel;
@property (weak, nonatomic) IBOutlet UISwitch *capsSwitch;

@end
