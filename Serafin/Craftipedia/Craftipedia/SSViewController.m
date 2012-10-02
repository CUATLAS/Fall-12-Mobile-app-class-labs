//
//  SSViewController.m
//  Craftipedia
//
//  Created by Scott Serafin on 10/1/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "SSViewController.h"
#import "MCItem.h"
#import "CustomCell.h"

@implementation SSViewController

@synthesize allTableData;
@synthesize filteredTableData;
@synthesize isFiltered;
@synthesize itemSearch;

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        isFiltered = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add our search bar
    itemSearch.delegate = (id)self;
    
	// Create our table with info
    allTableData = [[NSMutableArray alloc]initWithObjects:
                    [[MCItem alloc] initWithitemName:@"Stone" itemID:@"1" itemDescription:@"This is a description of stone" itemImage:@"stone.png"],
                    [[MCItem alloc] initWithitemName:@"Wool (Red)" itemID:@"35:14" itemDescription:@"This woold is red!" itemImage:@"redwool.png"]
                     , nil ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Count how many different sections we want to have, Alphabet and stuff
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Count the number of rows depending on if the data is being filtered or not
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if (self.isFiltered)
        rowCount = filteredTableData.count;
    else
        rowCount = allTableData.count;
    
    return rowCount;
}

// FILL THE TABLE WITH DATA FROM OUR MUTABLE ARRAY
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";  // This is what we named the Table View Cell
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];    // Call our custom class that defines our custom view style
    
    MCItem* mcitem;
    if(isFiltered)
        mcitem = [filteredTableData objectAtIndex:indexPath.row];   // Fill the table with only the filtered data
    else
        mcitem = [allTableData objectAtIndex:indexPath.row];        // Fill the table with all of the data
    
    cell.itemNameLabel.text = mcitem.itemName;  // Put the item name in the name label
    cell.itemIDLabel.text = mcitem.itemID;      // Put the item id# in the name label
    
    return cell;
}

// HANDLE SEARCHES FOR UITABLEVIEW
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)text
{
    if(text.length == 0)    // Nothing has been entered into the search box
    {
        isFiltered = NO;                // Set filtered to no because nothing has been entered into the search box
        [self.tableView reloadData];    // Reload the data (Useful for deleting all search content)
    }
    else
    {
        isFiltered = YES;   // Something was entered into the search box
        filteredTableData = [[NSMutableArray alloc] init];
        
        for (MCItem* mcitem in allTableData)
        {
            NSRange nameRange = [mcitem.itemName rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange idRange = [mcitem.itemID rangeOfString:text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || idRange.location != NSNotFound)
            {
                [filteredTableData addObject:mcitem];
            }
        }
        
    [self.tableView reloadData];    // Reload the Filtered list with the filtered resultes
    }
}

// When you press "Search", close the keyboard
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
