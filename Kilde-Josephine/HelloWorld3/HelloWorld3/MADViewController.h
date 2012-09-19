//
//  MADViewController.h
//  HelloWorld3
//
//  Created by  on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *NYImage;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
- (IBAction)chooseTeam:(UIButton *)sender;

@end
