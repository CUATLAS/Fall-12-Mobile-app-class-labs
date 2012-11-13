//
//  MADAddViewController.h
//  Countries2
//
//  Created by Jenna Raderstrong on 10/30/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddText.h"

@interface MADAddViewController : UIViewController

- (IBAction)doneButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textBox;
@property (strong, nonatomic)AddText *addNew;
@end
