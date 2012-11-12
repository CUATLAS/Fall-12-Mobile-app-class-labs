//
//  GamesViewController.m
//  GameScores
//
//  Created by Stephen Feuerstein on 11/6/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
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
    
    games = [NSMutableArray arrayWithObjects:@"Scrabble", @"Words With Friends", @"Other Scrabble Clone", nil];
    scores = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    games = nil;
    scores = nil;
    editedSelection = nil;
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
    return games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell"];
    cell.textLabel.text = [games objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [scores objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // AddGame
    if ([segue.identifier isEqualToString:@"AddGame"])
    {
        UINavigationController *navController = segue.destinationViewController;
        GameDetailsViewController *gameDetailsVC = [[navController viewControllers] objectAtIndex:0];
        gameDetailsVC.delegate = self;
    }
    
    // EnterScore segue
    if ([segue.identifier isEqualToString:@"EnterScore"])
    {
        UIViewController *destinationVC = segue.destinationViewController;
        if ([destinationVC respondsToSelector:@selector(setDelegate:)])
        {
            [destinationVC setValue:self forKey:@"delegate"];
        }
        
        // If lets us set selection, update destinationVC with selection value
        if ([destinationVC respondsToSelector:@selector(setSelection:)])
        {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            id object = [scores objectAtIndex:indexPath.row];
            NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", object, @"object", nil];
            [destinationVC setValue:selection forKey:@"selection"];
        }
    }
}

-(void)setEditedSelection:(NSDictionary *)dict
{
    if (![dict isEqual:editedSelection])
    {
        editedSelection = dict;
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        id newValue = [dict objectForKey:@"object"];
        
        [scores replaceObjectAtIndex:indexPath.row withObject:newValue];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

// Delegate methods
-(void)gameDetailsViewControllerDidCancel:(GameDetailsViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)gameDetailsViewController:(GameDetailsViewController *)viewController DidSave:(NSString *)newGame
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [games addObject:newGame];
    [scores addObject:@"0"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:games.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
