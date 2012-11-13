//
//  AddTaskViewController.h
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/10/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) NSDictionary *selection;
@property (weak, nonatomic) id delegate;
@end
