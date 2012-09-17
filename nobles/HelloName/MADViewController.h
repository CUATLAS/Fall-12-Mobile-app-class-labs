//
//  MADViewController.h
//  HelloName
//
//  Created by Mattie Nobles on 9/4/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
- (IBAction)textFieldDoneEditing:(id)sender;

@end
