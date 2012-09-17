//
//  MADViewController.h
//  Hello_World_3
//
//  Created by Scott Serafin on 9/4/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name_field;
@property (weak, nonatomic) IBOutlet UILabel *message_field;
- (IBAction)text_field_done_editing:(id)sender;

@end
