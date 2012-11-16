//
//  MADMasterViewController.m
//  Presidents
//
//  Created by Rachel Strobel on 11/1/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADMasterViewController.h"

#import "MADDetailViewController.h"

@interface MADMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MADMasterViewController
@synthesize presidents;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
  //  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //if (self) {
      //  self.title = NSLocalizedString(@"Presidents", @"Presidents");
        //self.clearsSelectionOnViewWillAppear = NO;
        //self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    //}
    //return self;
//}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	NSBundle *bundle=[NSBundle mainBundle]; //returns a bundle object of our app
    NSString *plistPath= [bundle pathForResource:@"PresidentList" ofType:@"plist"]; //retrieve the path of PresidentList.plist
    NSDictionary *presidentInfo=[NSDictionary dictionaryWithContentsOfFile:plistPath]; //loads the contents of the plist file into a dictionary
    self.presidents=[presidentInfo objectForKey:@"presidents"]; //assigns all the presidents keys to our array
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    presidents = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [presidents count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

//Configure the cell.
    NSDictionary *presidentChoosen=[self.presidents objectAtIndex:indexPath.row];//assigns dictionary item of the row
    cell.textLabel.text = [presidentChoosen objectForKey:@"name"];//assigns the value of name to the cell
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *presidentChosen = [self.presidents objectAtIndex:indexPath.row]; //assigns dictionary item of the row
    NSString *url=[presidentChosen objectForKey:@"url"]; //assigns the url of the row
    MADDetailViewController *detailViewController=self.detailViewController;
    detailViewController.detailItem =url; //assigns the url to the detailItem propery
}

@end
