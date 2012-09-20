//
//  MADViewController.h
//  HelloName_Final
//
//  Created by new user on 9/19/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
- (IBAction)textFieldDoneEditing:(id)sender;

@end
