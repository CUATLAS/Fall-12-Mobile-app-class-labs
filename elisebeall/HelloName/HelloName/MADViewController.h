//
//  MADViewController.h
//  HelloName
//
//  Created by Elise J Beall on 9/21/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
- (IBAction)textFieldDoneEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
