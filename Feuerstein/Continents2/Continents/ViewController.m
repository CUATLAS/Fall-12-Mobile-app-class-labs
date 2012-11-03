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

-(id)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:style]))
    {
        // Custom init style
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"continents" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
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
    // Initialize detailVC if !exist
    if (!detailVC)
    {
        detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    
    NSArray *rowData = [continentData allKeys];
    //NSString *rowValue = [rowData objectAtIndex:indexPath.row];
    detailVC.title = [rowData objectAtIndex:indexPath.row];
    detailVC.countryList = [continentData objectForKey:detailVC.title];
    
    // Deselect row, then push new view
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
// Make rows editable
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Commit edits if above method returns YES
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deleting rows
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // Inserting rows
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // INSERTING CODE
    }
}
 

// Rearranging table view
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

// Support for rearranging table view
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}*/

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
