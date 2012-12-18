//
//  SchoolsViewController.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "SchoolsViewController.h"

@interface SchoolsViewController ()

@end

@implementation SchoolsViewController

@synthesize schools, editedSelection;

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
    
    schools = [NSMutableArray arrayWithObjects:@"Aurora Central High", @"Boulder High", @"Longmont High", nil];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddSchool"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        SchoolDetailsViewController *schoolDetailsViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        schoolDetailsViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"EnterSchoolName"]) {
        NSLog(@"enter school name");
        //UINavigationController *navigationController = segue.destinationViewController;
        SchoolNameViewController *schoolNameViewController = segue.destinationViewController;
        
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        schoolNameViewController.title = [schools objectAtIndex:selectedRowIndexPath.row];
        
        //schoolNameViewController.delegate = self;
    }
}
    
    
    
-(void)schoolDetailsViewControllerDidCancel:(SchoolDetailsViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)schoolDetailsViewController:(SchoolDetailsViewController *)controller DidSave:(NSString *)newSchool {
    [schools addObject:newSchool];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[schools count]-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [schools count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolCell"];
    NSString *school = [schools objectAtIndex:indexPath.row];
    cell.textLabel.text = school;
   
    // Configure the cell...
    
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
