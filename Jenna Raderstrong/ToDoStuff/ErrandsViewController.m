//
//  ErrandsViewController.m
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/12/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "ErrandsViewController.h"

@interface ErrandsViewController ()

@end

@implementation ErrandsViewController
@synthesize errands, places, editedSelection;

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
    errands=[NSMutableArray arrayWithObjects: nil];
    places=[NSMutableArray arrayWithObjects: nil];
     self.navigationItem.leftBarButtonItem=self.editButtonItem;

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
    return YES;
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
    return [errands count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ErrandCell"];
    NSString *errand=[errands objectAtIndex:indexPath.row];
    cell.textLabel.text=errand;
    NSString *place=[places objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=place;
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"AddErrand"]){
    UINavigationController *navigationController = segue.destinationViewController;
        ErrandDetailsViewController *errandDetailsViewController =
        [[navigationController viewControllers] objectAtIndex:0];
        errandDetailsViewController.delegate = self;
    }
    
    
    if ([segue.identifier isEqualToString:@"EnterPlace"]){
        UIViewController *destination=segue.destinationViewController; 
        if ([destination respondsToSelector:@selector(setDelegate:)]){ 
            [destination setValue:self forKey:@"delegate"]; 
        }
        if ([destination respondsToSelector:@selector(setSelection:)]){ 
            NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
            id object=[places objectAtIndex:indexPath.row];
            NSDictionary *selection=[NSDictionary dictionaryWithObjectsAndKeys: indexPath, @"indexPath", object, @"object", nil];
            [destination setValue:selection forKey:@"selection"]; 
          
        }
    }
}

- (void)setEditedSelection:(NSDictionary *)dict {
    if (![dict isEqual:editedSelection]) {
        editedSelection = dict; 
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"]; 
        id newValue = [dict objectForKey:@"object"];
        [places replaceObjectAtIndex:indexPath.row withObject:newValue]; 
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic]; 
    }
}

-
(void)errandDetailsViewControllerDidCancel:(ErrandDetailsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)errandDetailsViewController: (ErrandDetailsViewController *)controller DidSave:(NSString *)newErrand{
     if(newErrand.length>0){
        [errands addObject:newErrand];
        [places addObject:@"Not Done"]; 
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[errands count]-1 inSection:0]; 
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation: UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
     }
        }


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=[indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [errands removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSUInteger fromRow=[fromIndexPath row];
    NSUInteger toRow=[toIndexPath row];
    NSString *moveErrand=[errands objectAtIndex:fromRow];
    [errands removeObjectAtIndex:fromRow];
    [errands insertObject:moveErrand atIndex:toRow];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < [errands count])
        return YES;
    else return NO;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
