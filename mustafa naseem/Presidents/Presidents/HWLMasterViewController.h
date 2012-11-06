//
//  HWLMasterViewController.h
//  Presidents
//
//  Created by  on 11/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWLDetailViewController;

@interface HWLMasterViewController : UITableViewController

@property (strong, nonatomic) HWLDetailViewController *detailViewController;

@property (strong, nonatomic) NSArray *presidents; 

@end
