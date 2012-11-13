//
//  SchoolsViewController.m
//  Sayansi
//
//  Created by  on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SchoolsViewController.h"

#import "SchoolWebViewController.h"

@interface SchoolsViewController () 

@end

@implementation SchoolsViewController

@synthesize schools;
@synthesize webViewController;

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
    
    
    NSBundle *bundle=[NSBundle mainBundle]; //Returns app bundle object
    NSString *plistPath=[bundle pathForResource:@"schoolList" ofType:@"plist"]; //Retrive plist path
    NSDictionary *schoolInfo=[NSDictionary dictionaryWithContentsOfFile:plistPath]; //Loads plist contents into a dictionary
    self.schools = [schoolInfo objectForKey:@"schools"]; //Assigns all keys to array
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    schools=nil;
    
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
//#warning Potentially incomplete method implementation.
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Return the number of rows in the section
   
    return [schools count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
   
    //Configure the cell
    NSDictionary *schoolChosen=[self.schools objectAtIndex:indexPath.row]; //Assigns dictionary item for the row
    cell.textLabel.text = [schoolChosen objectForKey:@"name"]; //Assigns the value of name to cell
    
    return cell;
}

//Notifies the view controller that a segue is about to be performed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];    
    NSDictionary *schoolChosen=[self.schools objectAtIndex:indexPath.row];    
    NSString *url = [schoolChosen objectForKey:@"url"]; //Assigns the url of the row
    SchoolWebViewController *webViewController = self.webViewController;
    webViewController.detailItem=url; //Assigns the url to the detailItem    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
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
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

*/



@end
