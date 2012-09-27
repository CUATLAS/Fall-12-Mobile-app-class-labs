//
//  BIDViewController.h
//  HelloWorld3
//
//  Created by Aileen Pierce on 8/21/12.
//  Copyright (c) 2012 Aileen Pierce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *NYImage;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
- (IBAction)chooseTeam:(UIButton *)sender;

@end
