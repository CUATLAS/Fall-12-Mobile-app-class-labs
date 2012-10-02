//
//  SSViewController.h
//  Craftipedia
//
//  Created by Scott Serafin on 10/1/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray* allTableData;         // Create an array that can be used to show all data
@property (strong, nonatomic) NSMutableArray* filteredTableData;    // Create an array that can be used to show filtered data
@property (nonatomic, assign) bool isFiltered;                      // Create a bool to mark if the data is being filtered or no
@property (weak, nonatomic) IBOutlet UISearchBar *itemSearch;



@end
