//
//  HWLAddCountryViewController.h
//  Countries2
//
//  Created by  on 11/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

@interface HWLAddCountryViewController : UIViewController <UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UITextField *addCountryField;
- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;
//@property (strong, nonatomic) Country *userInfo;

@end
