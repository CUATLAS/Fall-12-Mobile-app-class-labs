//
//  MADMasterViewController.m
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADMasterViewController.h"

#import "MADDetailViewController.h"

@implementation MADMasterViewController
@synthesize app;
@synthesize detailViewController = _detailViewController;
@synthesize countryList;
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    app = [[UIApplication sharedApplication] delegate];
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Countries";
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [app.listArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    countryList = [app.listArray objectAtIndex:indexPath.row];

    cell.textLabel.text = countryList.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // create new detail view and push that to the navigation controller
    MADDetailViewController *detailView = [[MADDetailViewController alloc] init];
    
    countryList = [app.listArray objectAtIndex:indexPath.row];
    
    detailView.countryList = countryList;
    
    [self.navigationController pushViewController:detailView animated:YES];
}

@end
