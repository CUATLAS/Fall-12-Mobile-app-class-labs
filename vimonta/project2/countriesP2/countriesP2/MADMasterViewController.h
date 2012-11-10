//
//  MADMasterViewController.h
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADMasterViewController : UITableViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (assign, nonatomic) BOOL isFiltered;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *) searchTerm;

@end
