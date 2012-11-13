//
//  MADMasterViewController.m
//  Countries3
//

#import "MADMasterViewController.h"
#import "MADDetailViewController.h"

@interface MADMasterViewController (){
    NSMutableDictionary *continentData;
    MADDetailViewController *detailViewController;
}

@end

@implementation MADMasterViewController

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
	NSBundle *bundle=[NSBundle mainBundle]; //returns a bundle object of our app
	NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"]; //retrieve the path of continents.plist
	NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]; //loads the contents of the plist file into a dictionary
	//the dictionary uses the continents as the keys and a NSArray with the countries for each continent.
	continentData=dictionary;
	self.title=@"Continents"; //sets the title of the controller
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    continentData=nil;
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
    return [continentData count]; //returns the number of continents
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	NSArray *rowData=[continentData allKeys]; //creates an array with all keys from our dictionary
	cell.textLabel.text=[rowData objectAtIndex:indexPath.row]; //sets the text of the cell with the row being requested
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!detailViewController) {
        detailViewController = [[MADDetailViewController alloc] initWithNibName:@"MADDetailViewController" bundle:nil];
    }
    NSArray *rowData=[continentData allKeys]; //creates an array with all keys from our dictionary
	detailViewController.title=[rowData objectAtIndex:indexPath.row]; //sets the title of the selected row
    //	countryList=[dictionary objectForKey:self.title]; //assigns the countries for the choosen continent to itemList
    
    detailViewController.countryList=[continentData objectForKey:detailViewController.title];
    [self.navigationController pushViewController:detailViewController animated:YES]; //push the detail view controller onto the navigation controller stack
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


@end