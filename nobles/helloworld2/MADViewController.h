//
//  MADViewController.h
//  helloworld2
//
//  Created by Mattie Nobles on 9/4/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
- (IBAction)buttonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageText;

@end
