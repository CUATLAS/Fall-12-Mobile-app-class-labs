//
//  MADMasterViewController.h
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADAppDelegate.h"
#import "MADCountryList.h"

@class MADDetailViewController;

@interface MADMasterViewController : UITableViewController

@property (strong, nonatomic) MADDetailViewController *detailViewController;
@property (nonatomic, retain) MADAppDelegate *app;
@property (nonatomic, retain) MADCountryList *countryList;

@end
