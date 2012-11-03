//
//  MADDetailViewController.h
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADCountryList.h"

@interface MADDetailViewController : UIViewController {
    IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) MADCountryList *countryList;
@end
