//
//  HWLDetailViewController.h
//  Disability List
//
//  Created by  on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWLDetailViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *countryList;
@property (weak, nonatomic) id delegate;



@end
