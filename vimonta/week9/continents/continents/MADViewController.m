//
//  MADViewController.m
//  continents
//
//  Created by Aaron Vimont on 10/23/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController () {
    NSDictionary *continentData;
}

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"continents" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    continentData = dictionary;
    self.title = @"Continents";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    continentData = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [continentData count];
}

// Customize the appearance of the table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    UIImage *world = [UIImage imageNamed:@"world.png"];
    cell.imageView.image = world;
    
    //cell.detailTextLabel.text = @"Earth";
    
    NSArray *rowData = [continentData allKeys]; // creates an array with all keys from our dictionary
    cell.textLabel.text = [rowData objectAtIndex:indexPath.row];
    
    NSArray *countryList = [continentData objectForKey:[rowData objectAtIndex:indexPath.row]];
    NSString *details = @"";
    
    for (int i = 0; i < [countryList count]; i++) {
        details = [details stringByAppendingString:[countryList objectAtIndex:i]];
        if (i < [countryList count] - 1) {
            details = [details stringByAppendingString:@", "];
        }
    }
    
    cell.detailTextLabel.text = details;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *rowData = [continentData allKeys];
    NSString *rowValue = [rowData objectAtIndex:indexPath.row];
    
    NSString *message = [[NSString alloc] initWithFormat:@"You selected %@", rowValue];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:message delegate:nil cancelButtonTitle:@"Gee Golly, I did!" otherButtonTitles:nil];
    
    [alert show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
