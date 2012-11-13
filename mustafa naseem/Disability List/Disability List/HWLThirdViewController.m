//
//  HWLThirdViewController.m
//  Disability List
//
//  Created by  on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLThirdViewController.h"

@interface HWLThirdViewController ()

@end

@implementation HWLThirdViewController
@synthesize detailViewController, continentData;

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
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    continentData=dictionary;
   // NSLog(@"%@",[continentData objectForKey:@"Cognitive"]);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [continentData count];
////}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier=@"CellIdentifier";
//    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    NSArray *rowData=[continentData allKeys];
//    cell.textLabel.text=[rowData objectAtIndex:indexPath.row];
//    return cell;
//}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    continentData=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
    return [continentData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
  
    /*if (!detailViewController) {
        detailViewController = [[HWLDetailViewController alloc] initWithNibName:@"HWLDetailViewController" bundle:nil];
    }
    
    NSLog(@"row data %@", rowData);
    detailViewController.title=[rowData objectAtIndex:indexPath.row];
    detailViewController.countryList=[continentData objectForKey:detailViewController.title];
    
    
    NSLog(@"cell data %@", cell);*/
    NSArray *rowData = [continentData allKeys];
     cell.textLabel.text=[rowData objectAtIndex:indexPath.row];
    return cell;
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in prepare for segue");
    // Make sure your segue name in storyboard is the same as this line
   if ([segue.identifier isEqualToString:@"DisabilityAppList"])
   {
       
       NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       
       NSArray *rowData = [continentData allKeys];
        NSLog(@"%@", rowData);
       

       detailViewController.title=[rowData objectAtIndex:indexPath.row];
       
       NSLog([NSString stringWithFormat:@"%d", indexPath.row]); 
       NSLog(@"Title");
       NSLog(detailViewController.title);
       detailViewController.countryList=[continentData objectForKey:detailViewController.title];
      NSLog(@"Array");
       NSLog(@"%@", detailViewController.countryList);
   }
}
       
       
       
       
       
       //NSString *cell = [rowData objectAtIndex:indexPath.row];
       //NSLog(@"cell data1 %@", cell);
       
      // cell.textLabel.text=[rowData objectAtIndex:indexPath.row];  
       //NSLog(@"title %@", hwlDetailViewController.title );

       /*HWLDetailViewController *hwlDetailViewController = [[navigationController viewControllers] objectAtIndex:indexPath.row];
       
       NSLog(@"title %@", hwlDetailViewController.title );
       
       
       hwlDetailViewController.countryList=[continentData objectForKey:hwlDetailViewController.title];
       hwlDetailViewController.delegate=self;
       [self.navigationController pushViewController:detailViewController animated:YES];*/

       
//        // Get reference to the destination view controller
//        HWLDetailViewController *vc = [segue destinationViewController];
//        
//        // Pass any objects to the view controller here, like...
//        [vc setMyObjectHere:object];
//        UIViewController *destination = segue.destinationViewController;
//        if ([destination respondsToSelector:@selector(setDelegate:)]) {
//            [destination setValue:self forKey:@"delegate"];
//        }
//        
//        if ([destination respondsToSelector:@selector(setselection:)]) {
//            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//            //id object = [self.tasks objectatindex 
//        }
//        if (!detailViewController) {
//            detailViewController = [[HWLDetailViewController alloc] initWithNibName:@"HWLDetailViewController" bundle:nil];
//        }
//        NSArray *rowData = [continentData allKeys];
//        detailViewController.title=[rowData objectAtIndex:indexPath.row];
//        detailViewController.countryList=[continentData objectForKey:detailViewController.title];
//        [self.navigationController pushViewController:detailViewController animated:YES];
//        
    



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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
