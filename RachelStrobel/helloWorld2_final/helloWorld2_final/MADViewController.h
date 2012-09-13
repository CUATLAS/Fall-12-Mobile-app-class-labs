//
//  MADViewController.h
//  helloWorld2_final
//
//  Created by Rachel Strobel on 9/13/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *messageTextHello;
- (IBAction)ButtonPress:(UIButton *)sender;

@end
