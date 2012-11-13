//
//  SchoolsViewController.h
//  Sayansi
//
//  Created by  on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolWebViewController.h"

@interface SchoolsViewController : UITableViewController 

@property (strong, nonatomic) SchoolWebViewController *webViewController;
@property (strong, nonatomic)NSArray *schools;

@end
