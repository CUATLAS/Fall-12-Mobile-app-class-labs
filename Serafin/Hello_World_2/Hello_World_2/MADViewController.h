//
//  MADViewController.h
//  Hello_World_2
//
//  Created by Scott Serafin on 9/4/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *hello_text;
- (IBAction)hello_button:(UIButton *)sender;

@end
