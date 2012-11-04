//
//  HWLDetailViewController.h
//  Countries2
//
//  Created by  on 10/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import "HWLAddCountryViewController.h"

@interface HWLDetailViewController : UITableViewController {
    Country *country;
}

@property (strong, nonatomic) NSMutableArray *countryList;

@end
