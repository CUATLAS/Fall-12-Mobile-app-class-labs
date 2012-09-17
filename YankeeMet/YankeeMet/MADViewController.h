//
//  MADViewController.h
//  YankeeMet
//
//  Created by Jenna Raderstrong on 9/16/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *NYImage;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
- (IBAction)chooseTeam:(UIButton *)sender;

@end
