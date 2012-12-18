//
//  SchoolsViewController.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolDetailsViewController.h"
#import "SchoolNameViewController.h"

@interface SchoolsViewController : UITableViewController <SchoolDetailsViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *schools;
@property (copy, nonatomic) NSDictionary *editedSelection;

@end
