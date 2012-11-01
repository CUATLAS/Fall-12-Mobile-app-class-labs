//
//  ViewController.m
//  Continents
//
//  Created by Scott Serafin on 10/23/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSDictionary *continentData;
}
    
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"continents" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    continentData = dictionary;
    self.title = @"Continents";  // Sets the title of the Table View
}


// Count how many rows there should be in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [continentData count];
}


// Create a cell within the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    NSArray *rowData = [continentData allKeys];
    
    UIImage *worldImage = [UIImage imageNamed:@"world.png"];
    cell.imageView.image = worldImage;
    
    cell.detailTextLabel.text = @"Cool Continent";
    
    cell.textLabel.text = [rowData objectAtIndex:indexPath.row];
    return cell;
    
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rowData = [continentData allKeys];
    NSString *rowValue = [rowData objectAtIndex:indexPath.row];
    NSString *message = [[NSString alloc] initWithFormat:@"You selected %@", rowValue];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:message delegate:nil cancelButtonTitle:@"Yup." otherButtonTitles: nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// Clean that memory!
- (void) viewDidUnload
{
    [super viewDidUnload];
    continentData = nil;
}

@end
