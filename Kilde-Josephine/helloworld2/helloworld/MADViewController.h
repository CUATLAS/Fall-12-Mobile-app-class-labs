//
//  MADViewController.h
//  helloworld
//
//  Created by  on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
// Import calls the UIKit function
// UIKit.h is a header file

@interface MADViewController : UIViewController

- (IBAction)buttonPressed:(UIButton *)sender;
// Colon shows class and subclass
// MADViewController is in the UIViewController class
// UIViewController is in the UIKit framework

@property (weak, nonatomic) IBOutlet UILabel *messageText;
// @property creates setter and getter methods

@end
