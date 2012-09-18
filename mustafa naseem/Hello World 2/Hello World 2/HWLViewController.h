//
//  HWLViewController.h
//  Hello World 2
//
//  Created by  on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *messageText;
- (IBAction)buttonPressed:(UIButton *)sender;

@end
