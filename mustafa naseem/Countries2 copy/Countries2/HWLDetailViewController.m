//
//  HWLDetailViewController.m
//  Countries2
//
//  Created by  on 10/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLDetailViewController.h"
#import "HWLAddCountryViewController.h"
#import "Country.h"

@interface HWLDetailViewController () 

@end

@implementation HWLDetailViewController
@synthesize countryList; 

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
   // addCountryField.text=country.word; 
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    country=[[Country alloc] init];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    countryList=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    country=nil;
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
    
    if (self.editing) 
        return [countryList count]+1;
    else return [countryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BOOL addCell=(indexPath.row==[countryList count]);
    if (addCell) 
        CellIdentifier = @"AddCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    if (addCell) {
        
       
        
         cell.textLabel.text= @"add new country";
    }
       else cell.textLabel.text=[countryList objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row= [indexPath row]; 
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [countryList removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
         
    }
    
    else if (editingStyle==UITableViewCellEditingStyleInsert) {
        //create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        HWLAddCountryViewController *myHWLAddCountryViewController = [[HWLAddCountryViewController alloc] init];
        
        myHWLAddCountryViewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:myHWLAddCountryViewController animated:YES completion:NULL];
        
  // NSString *newItem = country.text ;
//        
//       NSString *newItem = @"New Country";
//        [countryList insertObject:newItem atIndex:indexPath.row];
//        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUInteger fromRow=[fromIndexPath row]; //row moving form
    NSUInteger toRow=[toIndexPath row]; //row moving to
    NSString *moveCountry = [countryList objectAtIndex:fromRow];
    
    if (toRow<[countryList count]) {
        
        [countryList removeObjectAtIndex: fromRow]; //remove the country from the row
        [countryList insertObject:moveCountry atIndex:toRow]; // insert the country in the new row
    }
    else {
        [countryList insertObject:moveCountry atIndex:[countryList count]];
    }
[self.tableView reloadData];
        
    }



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < [countryList count])
    // Return NO if you do not want the item to be re-orderable.
    return YES;
    else return NO;
}


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

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (indexPath.row==[countryList count])
        return UITableViewCellEditingStyleInsert;
    else return UITableViewCellEditingStyleDelete;
}



-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
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

@end
