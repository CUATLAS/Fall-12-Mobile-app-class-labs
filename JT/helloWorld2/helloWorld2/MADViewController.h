//
//  MADViewController.h
//  helloWorld2
//
//  Created by John Birchall on 9/16/12.
//  Copyright (c) 2012 John Birchall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
- (IBAction)textFieldDoneEditing:(id)sender;
@end
