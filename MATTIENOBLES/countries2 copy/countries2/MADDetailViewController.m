//
//  MADDetailViewController.m
//  countries2
//
//  Created by Mattie Nobles on 10/25/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "MADDetailViewController.h"

@interface MADDetailViewController ()

@end

@implementation MADDetailViewController
@synthesize countryList;

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

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
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    /*NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    countryList=[dictionary objectForKey:self.title];
    [self.tableView reloadData]; */
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(self.editing)
    return [countryList count]+1;
    else return [countryList count];
    //editing or adding the number of countries in the country list
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //(Below) to add more cells 
    BOOL addCell=(indexPath.row==[countryList count]);
    if (addCell)
        CellIdentifier = @"AddCell";
    //^ to add more cells 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //Below, to add more cells 
    if(addCell){
        cell.textLabel.text = @"add new country";
    }
    //^ to add more cells 
    else cell.textLabel.text=[countryList objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}
//impliment the moving of rows
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUInteger fromRow=[fromIndexPath row];
    NSUInteger toRow=[toIndexPath row];
    NSString *moveCountry=[countryList objectAtIndex:fromRow];
    if(toRow<[countryList count]){
    [countryList removeObjectAtIndex:fromRow];
    [countryList insertObject:moveCountry atIndex:toRow];
}
else{
    [countryList removeObjectAtIndex:fromRow];
    [countryList insertObject:moveCountry atIndex:[countryList count]];
}
[self.tableView reloadData];
}
//allows rows to be moved
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [countryList count])
    // Return NO if you do not want the specified item to be editable.
    return YES;
    else return NO;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [countryList count])
        return UITableViewCellEditingStyleInsert;
    else return UITableViewCellEditingStyleDelete;
}


// Override to support editing the table view.

//to add the edit button at the right side of the top toolbar
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    [countryList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
            withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSString *newItem = @"new country";
        [countryList insertObject:newItem atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath
                                                                    indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [tableView reloadData];
}
//if you are editing the list it calls begin updates, inserts the row, and end updates, and if editing is false that means you are deleting the info

-(void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if (editing) {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    } else {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    }
}

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
