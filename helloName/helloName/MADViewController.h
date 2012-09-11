//
//  MADViewController.h
//  helloName
//
//  Created by Aaron Vimont on 9/4/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@property (weak, nonatomic) IBOutlet UILabel *whereFrom;
@property (weak, nonatomic) IBOutlet UITextField *whereFromInputField;
@property (weak, nonatomic) IBOutlet UILabel *lovely;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)whereFromDoneEditing:(UITextField *)sender;

@end
