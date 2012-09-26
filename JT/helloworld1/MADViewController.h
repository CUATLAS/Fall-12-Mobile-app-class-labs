//
//  MADViewController.h
//  helloworld1
//
//  Created by  on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
- (IBAction)buttonpressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageText;

@end
