//
//  ViewController.m
//  Continents
//
//  Created by Stephen Feuerstein on 10/23/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"continents" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    // Copy data into continentData
    continentData = dict;
    self.title = @"Continents";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return continentData.count;
}

// Customize table view cells
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        // Cell is empty, initialize
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure cell
    UIImage *worldImage = [UIImage imageNamed:@"world.png"];
    cell.imageView.image = worldImage;
    NSArray *rowData = [continentData allKeys]; // Data for rows
    cell.textLabel.text = [rowData objectAtIndex:indexPath.row]; // Sets text to indexPath's row
    
    return cell;
}

// Row selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rowData = [continentData allKeys];
    NSString *rowValue = [rowData objectAtIndex:indexPath.row];
    NSString *message = [NSString stringWithFormat:@"You selected %@", rowValue];
    
    // Display an alert view for now, and deselect row
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:message delegate:self cancelButtonTitle:@"Great..." otherButtonTitles:nil, nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    continentData = nil;
    [super viewDidUnload];
}
@end
