//
//  ErrandsViewController.h
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/12/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrandDetailsViewController.h"
@interface ErrandsViewController : UITableViewController
<ErrandDetailsViewControllerDelegate>
@property(strong, nonatomic) NSMutableArray *errands;
@property(strong, nonatomic)NSMutableArray *places;
@property(copy, nonatomic)NSDictionary *editedSelection;

@end
