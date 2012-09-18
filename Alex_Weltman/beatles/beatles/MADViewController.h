//
//  MADViewController.h
//  beatles
//
//  Created by  on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *beatlesImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)changedImage:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl;
@property (weak, nonatomic) IBOutlet UISwitch *capSwitch;
- (IBAction)updateFont:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeNumLabel;
- (IBAction)scaleFont:(UISlider *)sender;


@end
