//
//  MADDetailViewController.m
//  countries2
//
//  Created by Rachel Strobel on 10/25/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADDetailViewController.h"

@interface MADDetailViewController ()

@end

@implementation MADDetailViewController
@synthesize countryList;

-(void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];//reloads the data in the tableView
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
    
    //NSBundle *bundle=[NSBundle mainBundle];
    //NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"];
    //NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]
                                     //initWithContentsOfFile:plistPath];
    //countryList=[dictionary objectForKey:self.title];
    //[self.tableView reloadData];
    //self.navigationItem.rightBarButtonItem=self.editButtonItem;
    

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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.editing)
        return [countryList count]+1;
    else return [countryList count];
}

//Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BOOL addCell=(indexPath.row==[countryList count]);
    if(addCell)
        CellIdentifier = @"AddCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(addCell){
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView
editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [countryList count])
        return UITableViewCellEditingStyleInsert;
    else return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [countryList removeObjectAtIndex:indexPath.row];//removes the row being deleted from the array
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSString *newItem = @"new country";
        [countryList insertObject:newItem atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation: UITableViewRowAnimationFade];
    }
    [tableView reloadData];
}

-(void)setEditing:(BOOL)editing animated: (BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if(editing){
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
     [self.tableView endUpdates];
     } else {
         [self.tableView beginUpdates];
         [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
         [self.tableView endUpdates];
     }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
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

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
if(indexPath.row < [countryList count])
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

@end
