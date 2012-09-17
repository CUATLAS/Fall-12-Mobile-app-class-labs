//
//  MADViewController.h
//  Hello_World_4
//
//  Created by Scott Serafin on 9/11/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *NYImage;
@property (weak, nonatomic) IBOutlet UILabel *message_field;
- (IBAction)choose_team:(UIButton *)sender;

@end
