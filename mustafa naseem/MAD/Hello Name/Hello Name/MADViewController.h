//
//  MADViewController.h
//  Hello Name
//
//  Created by  on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UILabel *messagefield;
- (IBAction)textFieldDoneEditing:(id)sender;

@end
