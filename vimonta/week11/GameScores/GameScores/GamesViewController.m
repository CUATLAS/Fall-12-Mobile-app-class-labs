//
//  GamesViewController.m
//  GameScores
//
//  Created by Aaron Vimont on 11/6/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "GamesViewController.h"

@interface GamesViewController ()

@end

@implementation GamesViewController
@synthesize games, scores, editedSelection;

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
    games = [NSMutableArray arrayWithObjects:@"Scrabble", @"Words with Friends", @"Boggle", nil];
    scores = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    games = nil;
    scores = nil;
    editedSelection = nil;
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
    return [games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell"];
    
    NSString *game = [games objectAtIndex:indexPath.row];
    cell.textLabel.text = game;
    
    NSString *score = [scores objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = score;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EnterScore"]) {
        // view controller that is about to be displayed
        UIViewController *destination = segue.destinationViewController;
        
        // checks if the destination controller has a delegate
        if ([destination respondsToSelector:@selector(setDelegate:)]) {
            // sets the destinations's delegate back to this view controller
            [destination setValue:self forKey:@"delegate"];
        }
        // checks if the destination lets us set the selection
        if ([destination respondsToSelector:@selector(setSelection:)]) {
            // gets the indexPath of the selected cell
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            // gets the object at the selected row
            id object = [scores objectAtIndex:indexPath.row];
            
            // puts the selected row and index of the selected row into a dictionary to pass along to the detail view controller
            NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", object, @"object", nil];
            // set the destinations selection property
            [destination setValue:selection forKey:@"selection"];
        }
    }
    if ([segue.identifier isEqualToString:@"AddGame"]) {
        // gets the GameDetailsViewController instance from the navigation controller's view controller's array
        UINavigationController *navigationController = segue.destinationViewController;
        GameDetailsViewController *gameDetailsViewController = [[navigationController viewControllers] objectAtIndex:0];
        gameDetailsViewController.delegate = self; // assigns the delegate
    }
}

// custom setter method for editedSelection
- (void)setEditedSelection:(NSDictionary *)dict {
    if (![dict isEqual:editedSelection]) {
        editedSelection = dict; // gets the dictionary of the edited item
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"]; // gets the indexPath of the edited item
        id newValue = [dict objectForKey:@"object"];
        [scores replaceObjectAtIndex:indexPath.row withObject:newValue];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic]; // reloads the table view
    }
}

- (void)gameDetailsViewControllerDidCancel:(GameDetailsViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)gameDetailsViewController:(GameDetailsViewController *)controller DidSave:(NSString *)newGame WithScore:(NSString *)score {
    [games addObject:newGame];
    [scores addObject:score];
    
    // insert the new game in the table using row animation
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[games count]-1 inSection:0]; // get the next blank row
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
