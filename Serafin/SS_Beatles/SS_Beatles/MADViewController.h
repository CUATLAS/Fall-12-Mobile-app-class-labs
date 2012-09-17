//
//  MADViewController.h
//  SS_Beatles
//
//  Created by Scott Serafin on 9/13/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *beatles_image;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UISegmentedControl *age_control;
- (IBAction)age_selector:(UISegmentedControl *)sender;
- (IBAction)text_slider:(UISlider *)sender;
- (IBAction)capital_switch:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *switch_label;
@property (weak, nonatomic) IBOutlet UILabel *font_size_label;

@end
