//
//  AddTaskViewController.h
//  Tasks
//
//  Created by Stephen Feuerstein on 11/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Task.h"

@interface AddTaskViewController : UITableViewController <RKObjectLoaderDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (nonatomic, strong) Task *task;

@end
