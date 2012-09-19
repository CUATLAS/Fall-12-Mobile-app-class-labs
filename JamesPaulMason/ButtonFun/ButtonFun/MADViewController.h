//
//  MADViewController.h
//  ButtonFun
//
//  Created by James Mason on 9/4/12.
//  Copyright (c) 2012 Trinary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelText;

- (IBAction)buttonPressed:(UIButton *)sender;

@end
