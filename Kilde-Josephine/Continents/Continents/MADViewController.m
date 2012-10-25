//
//  MADViewController.m
//  Continents
//
//  Created by  on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController (){
    NSDictionary *continentData;
}

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle=[NSBundle mainBundle]; //Returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"]; //Retrieve the path of the continents.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath]; //Loads the contents of the plist file into a dictionary
    //The dictionary uses the continents as the keys and a NSArray with the countires for each continent
    continentData=dictionary;
    self.title=@"Continents";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//Customize the number of rows in the table view
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger) section
{
    return [continentData count]; //Returns the number of continents
}

//Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: cellIdentifier];
    
    }
    
//Configure the cell
    UIImage *world=[UIImage imageNamed:@"world.png"]; //Class UIImage; Object *world
    cell.imageView.image=world; //Sets the cell's image
    cell.detailTextLabel.text=@"Earth";
    NSArray *rowData=[continentData allKeys]; //Creates and array with all keys from our dictionary
    cell.textLabel.text=[rowData objectAtIndex:indexPath.row]; //Sets the text of the cell with the row being requested
    return cell;
}

//UITableViewDelegate method that is called when a row is selected
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rowData=[continentData allKeys]; //Creates an array with all keys from our dictionary
    NSString *rowValue=[rowData objectAtIndex:indexPath.row]; //Sets the title of the selected row
    NSString *message=[[NSString alloc] initWithFormat:@"You selecte %@", rowValue];
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"Row Selected" message:message delegate:nil 
                        cancelButtonTitle:@"Yes, I Did" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //Deselcts the row that has been chosen
}

@end
