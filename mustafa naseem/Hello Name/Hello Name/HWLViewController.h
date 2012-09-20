//
//  HWLViewController.h
//  Hello Name
//
//  Created by  on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
- (IBAction)textFieldDoneEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageField;

@end
