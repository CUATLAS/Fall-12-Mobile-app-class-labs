//
//  TasksViewController.h
//  Tasks
//
//  Created by Stephen Feuerstein on 11/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface TasksViewController : UITableViewController <RKObjectLoaderDelegate>

@property (strong, nonatomic) NSArray *tasks;

@end
