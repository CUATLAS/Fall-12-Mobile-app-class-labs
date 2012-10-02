//
//  MADViewController.h
//  ColorMixer
//
//  Created by Jenna Raderstrong on 9/30/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController 
- (IBAction)chooseColor:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *color1;
@property (weak, nonatomic) IBOutlet UITextField *color2;
- (IBAction)mixButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleHeader;
- (IBAction)tryAgain:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@end
