//
//  HomeworkViewController.h
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/10/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeworkDetailsViewController.h"
@interface HomeworkViewController : UITableViewController
<HomeworkDetailsViewControllerDelegate>
@property(strong, nonatomic) NSMutableArray *homework;
@property(strong, nonatomic)NSMutableArray *task;
@property(copy, nonatomic)NSDictionary *editedSelection;

@end
