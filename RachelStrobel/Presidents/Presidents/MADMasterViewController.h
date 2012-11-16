//
//  MADMasterViewController.h
//  Presidents
//
//  Created by Rachel Strobel on 11/1/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MADDetailViewController;

@interface MADMasterViewController : UITableViewController

@property (strong, nonatomic) MADDetailViewController *detailViewController;

@property (strong, nonatomic) NSArray *presidents;

@end
