//
//  MoocsListViewController.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "MoocsListViewController.h"
#import "MoocsWebViewController.h"


@interface MoocsListViewController ()

@end

@implementation MoocsListViewController

@synthesize moocs, webViewController, detailItem;

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
    NSString *plistPath=[bundle pathForResource:@"moocList" ofType:@"plist"];
    NSDictionary *moocInfo=[NSDictionary dictionaryWithContentsOfFile:plistPath];
    self.moocs = [moocInfo objectForKey:@"moocs"];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    moocs = nil;
    
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
    return [moocs count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoocCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *moocChosen=[self.moocs objectAtIndex:indexPath.row];
    cell.textLabel.text = [moocChosen objectForKey:@"name"];
    NSLog(@"test1");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did select row");
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"test 6");
    if ([segue.identifier isEqualToString:@"MoocsWeb"]){
        NSLog(@"test 5");
        
        webViewController = segue.destinationViewController;
        NSLog(@"test2");
        NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
        NSDictionary *moocChosen=[self.moocs objectAtIndex:indexPath.row];
        NSString *url = [moocChosen objectForKey:@"url"];
        //MoocsWebViewController *webViewController = self.webViewController;
        webViewController.detailItem = url;
    }
    /*webViewController = segue.destinationViewController;
     NSLog(@"test2");
     NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
     NSDictionary *moocChosen=[self.moocs objectAtIndex:indexPath.row];
     NSString *url = [moocChosen objectForKey:@"url"];
     //MoocsWebViewController *webViewController = self.webViewController;
     webViewController.detailItem = url;*/
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


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

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 
 }
 */

@end
