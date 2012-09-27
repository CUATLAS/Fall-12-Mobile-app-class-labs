//
//  MADViewController.h
//  HelloImage
//
//  Created by Elise J Beall on 9/25/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *messageField;
- (IBAction)chooseTeam:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
