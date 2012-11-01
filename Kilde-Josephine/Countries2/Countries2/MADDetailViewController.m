//
//  MADDetailViewController.m
//  Countries2
//
//  Created by  on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADDetailViewController.h"

@interface MADDetailViewController ()

@end

@implementation MADDetailViewController
@synthesize countryList;

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
    /*NSBundle *bundle=[NSBundle mainBundle]; //Returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]
                                     initWithContentsOfFile:plistPath]; //Loads the contents of the plist file into a dictionary
    countryList=[dictionary objectForKey:self.title]; //Assigns the countries for the choosen continent to itemList
    [self.tableView reloadData]; //Reloads the data in the tableView

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;*/
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData]; //Reload the data in the tableView
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

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Return the number of rows in the section
    if (self.editing) 
        return [countryList count]+1; //Adds a row for insertion if in edit mode
        else return [countryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BOOL addCell=(indexPath.row==[countryList count]); //True if adding a row
    if(addCell)
        CellIdentifier = @"AddCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(addCell){
        cell.textLabel.text = @"add new country"; //Sets test of added cell
    }
    else cell.textLabel.text=[countryList objectAtIndex:indexPath.row]; //Sets the text of the cell with the row being requested
    return cell;
}


//Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//Sets the editing style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [countryList count])
        return UITableViewCellEditingStyleInsert;
    else return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
//Called by the table view when the user has made an edit - a deletion or an insertion
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [countryList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        NSString *newItem = @"New Country";
        [countryList insertObject:newItem atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }   
    [tableView reloadData];
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if(editing) {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    }
    else {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUInteger fromRow=[fromIndexPath row]; //Row moving from
    NSUInteger toRow=[toIndexPath row]; //Row moving to
    NSString *moveCountry=[countryList objectAtIndex:fromRow]; //The country we are moving
    if(toRow < [countryList count]) {
    [countryList removeObjectAtIndex:fromRow]; //Remove the country from row
    [countryList insertObject:moveCountry atIndex:toRow]; //Insert the country in the new row
    }
    else {
        [countryList removeObjectAtIndex:fromRow]; //Remove the country from the row
        [countryList insertObject:moveCountry atIndex:[countryList count]]; //Insert the country in the new row
    }
}


//Allows rows to be moved
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < [countryList count])
        return YES;
    else return NO;
}
/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//#pragma mark - Table view delegate

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
