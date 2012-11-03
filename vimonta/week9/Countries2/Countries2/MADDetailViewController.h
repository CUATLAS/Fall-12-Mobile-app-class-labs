//
//  MADDetailViewController.h
//  Countries2
//
//  Created by Aaron Vimont on 10/25/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADSavedCountry.h"
#import "MADNewCountryViewController.h"

@interface MADDetailViewController : UITableViewController {
    MADSavedCountry *theNewCountry;
}

@property (strong, nonatomic) NSMutableArray *countryList;
@property (strong, nonatomic) MADNewCountryViewController *infoViewController;

@end
