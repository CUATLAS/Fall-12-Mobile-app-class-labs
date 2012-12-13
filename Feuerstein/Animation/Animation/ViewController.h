//
//  ViewController.h
//  Animation
//
//  Created by Stephen Feuerstein on 11/15/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;

- (IBAction)sliderValueChanged:(UISlider *)sender;

@end
