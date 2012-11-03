//
//  BIDViewController.h
//  Hello World
//
//  Created by Aileen Pierce on 7/6/12.
//  Copyright (c) 2012 University of Colorado at Boulder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *messageText;
- (IBAction)buttonPressed:(UIButton *)sender;

@end