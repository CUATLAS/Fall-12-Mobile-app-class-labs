//
//  MADMasterViewController.h
//  Presidents
//
//  Created by Mattie Nobles on 11/1/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MADDetailViewController;

@interface MADMasterViewController : UITableViewController

@property (strong, nonatomic) MADDetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *presidents;

@end
