//
//  HWLThirdViewController.h
//  Disability List
//
//  Created by  on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWLDetailViewController.h"


@interface HWLThirdViewController : UITableViewController
@property (strong, nonatomic) NSDictionary *continentData;
@property (strong, nonatomic) HWLDetailViewController *detailViewController;

@end
