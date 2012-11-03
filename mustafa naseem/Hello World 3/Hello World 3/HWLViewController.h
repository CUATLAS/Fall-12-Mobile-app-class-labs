//
//  HWLViewController.h
//  Hello World 3
//
//  Created by  on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *NYImage;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
- (IBAction)chooseTeam:(UIButton *)sender;

@end
