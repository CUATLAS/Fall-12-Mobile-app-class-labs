//
//  MADMasterViewController.m
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADMasterViewController.h"
#import "MADDetailViewController.h"
#import "MADStoredData.h"

@interface MADMasterViewController () {
    NSDictionary *countryData;
    NSMutableDictionary *filteredCountryData;
    
    MADDetailViewController *detailViewController;
}

@end

@implementation MADMasterViewController
@synthesize search;
@synthesize isFiltered;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    search.delegate = self;
    
    self.navigationController.navigationBar.hidden = NO;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"longCountryListPlist" ofType:@"plist"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    countryData = dictionary;
    self.title = @"Countries";
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0.0, 44.0) animated:NO];
}

- (void)viewDidUnload
{
    [self setSearch:nil];
    [super viewDidUnload];
    countryData = nil;
    filteredCountryData = nil;
    search = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [search resignFirstResponder];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)gdpIsNotInRange: (NSString *)countryName {
    NSArray *countryDetail = [countryData objectForKey:countryName];
    NSString *gdpStr = (NSString *)[countryDetail objectAtIndex:0];
    CGFloat gdpVal = [gdpStr floatValue];
    
    if (gdpVal <= [MADStoredData sharedInstance].lowValue) {
        return YES;
    }
    else if (gdpVal > [MADStoredData sharedInstance].highValue) {
        return YES;
    }
    return NO;
}

- (BOOL)popIsNotInRange: (NSString *)countryName {
    NSArray *countryDetail = [countryData objectForKey:countryName];
    NSString *popStr = (NSString *)[countryDetail objectAtIndex:1];
    CGFloat popVal = [popStr floatValue];
    
    if (popVal <= [MADStoredData sharedInstance].lowValue) {
        return YES;
    }
    else if (popVal > [MADStoredData sharedInstance].highValue) {
        return YES;
    }
    return NO;
}

- (BOOL)aidsIsNotInRange: (NSString *)countryName {
    NSArray *countryDetail = [countryData objectForKey:countryName];
    NSString *aidsStr = (NSString *)[countryDetail objectAtIndex:2];
    CGFloat aidsVal = [aidsStr floatValue];
    
    if (aidsVal <= [MADStoredData sharedInstance].lowValue) {
        return YES;
    }
    else if (aidsVal > [MADStoredData sharedInstance].highValue) {
        return YES;
    }
    return NO;
}

- (BOOL)valuesNotInRange: (NSString *)countryName {
    NSArray *countryDetail = [countryData objectForKey:countryName];
    NSString *valueStr = (NSString *)[countryDetail objectAtIndex:[MADStoredData sharedInstance].currentSegment];
    CGFloat floatVal = [valueStr floatValue];
    
    if (floatVal <= [MADStoredData sharedInstance].lowValue) {
        return YES;
    }
    else if (floatVal > [MADStoredData sharedInstance].highValue) {
        return YES;
    }
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered) {
        return [filteredCountryData count];
    }
    else {
        return [countryData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    /*countryList = [app.listArray objectAtIndex:indexPath.row];
     
     cell.textLabel.text = countryList.name;
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;*/
    
    NSArray *rowData;
    if (isFiltered) {
        //NSLog(@"Filtered");
        //rowData = [[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
        rowData = [[NSArray alloc] initWithArray:[[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    else {
        //NSLog(@"Not filtered");
        //rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
        rowData = [[NSArray alloc] initWithArray:[[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    //NSArray *rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    cell.textLabel.text = [rowData objectAtIndex:indexPath.row];
    if ([MADStoredData sharedInstance].currentSegment != -1 && [self valuesNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        cell.hidden = YES;
    }
    
    /*if ([MADStoredData sharedInstance].currentSegment == 0 && [self gdpIsNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        cell.hidden = YES;
    }
    else if ([MADStoredData sharedInstance].currentSegment == 1 && [self popIsNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        cell.hidden = YES;
    }
    else if ([MADStoredData sharedInstance].currentSegment == 2 && [self aidsIsNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        cell.hidden = YES;
    }*/
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rowData;
    if (isFiltered) {
        //rowData = [[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
        rowData = [[NSArray alloc] initWithArray:[[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    else {
        //rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
        rowData = [[NSArray alloc] initWithArray:[[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    
    if ([MADStoredData sharedInstance].currentSegment != -1 && [self valuesNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        return 0.0;
    }
    
    //NSArray *rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    /*if ([MADStoredData sharedInstance].currentSegment == 0 && [self gdpIsNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        return 0.0;
    }
    else if ([MADStoredData sharedInstance].currentSegment == 1 && [self popIsNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        return 0.0;
    }
    else if ([MADStoredData sharedInstance].currentSegment == 2 && [self aidsIsNotInRange: [rowData objectAtIndex: indexPath.row]]) {
        return 0.0;
    }*/
    return 44.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!detailViewController) {
        detailViewController = [[MADDetailViewController alloc] initWithNibName:@"MADDetailViewController" bundle:nil];
    }
    
    NSArray *rowData = [[NSArray alloc] init];
    if (isFiltered) {
        //rowData = [[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
        rowData = [[NSArray alloc] initWithArray:[[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    else {
        //rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
        rowData = [[NSArray alloc] initWithArray:[[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    
    //NSLog(@"Afghan gdp: %@", [[countryData objectForKey:@"Afghanistan"] objectAtIndex:0]);
    //NSLog(@"Albania gdp: %@", [[countryData objectForKey:@"Albania"] objectAtIndex:0]);
    
    //NSArray *rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    detailViewController.title = [rowData objectAtIndex:indexPath.row];
    detailViewController.countryArray = [countryData objectForKey:detailViewController.title];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

// Search Bar Methods
- (void)resetSearch {
    filteredCountryData = nil;
    isFiltered = NO;
}

- (void)handleSearchForTerm:(NSString *)searchTerm {
    isFiltered = YES;
    filteredCountryData = [[NSMutableDictionary alloc] init];
    NSArray *rowData = [[NSArray alloc] initWithArray:[[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    NSUInteger i;
    
    for (i = 0; i < [rowData count]; i++) {
        NSRange nameRange = [[rowData objectAtIndex:i] rangeOfString:searchTerm options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [filteredCountryData setObject:[countryData objectForKey:[rowData objectAtIndex:i]] forKey:[rowData objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchTerm = [searchBar text];
    [self handleSearchForTerm:searchTerm];
    [search resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        [self resetSearch];
        [self.tableView reloadData];
        return;
    }
    [self handleSearchForTerm:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    search.text = @"";
    [self resetSearch];
    [search resignFirstResponder];
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] != search) {
        [search resignFirstResponder];
    }
}

@end
