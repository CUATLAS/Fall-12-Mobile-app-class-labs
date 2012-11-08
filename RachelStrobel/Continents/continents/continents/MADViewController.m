//
//  MADViewController.m
//  continents
//
//  Created by Rachel Strobel on 10/23/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
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
    NSBundle *bundle=[NSBundle mainBundle];//returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"];//retrieve the path of continents.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    continentData=dictionary;
    self.title=@"Continents";//sets the title of the controller
	// Do any additional setup after loading the view, typically from a nib.
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger) section
{
    return [continentData count]; //returns the number of continents
}

//Customize the appearance of table view calls.
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    //Configure the cell
    UIImage *world=[UIImage imageNamed:@"world.png"];
    cell.imageView.image=world; //sets the cell's image
    cell.detailTextLabel.text=@"Earth";
    NSArray *rowData = [continentData allKeys]; //creates an array with all keys from our dictionary
    cell.textLabel.text = [rowData objectAtIndex:indexPath.row]; //sets the text of the cell with the row being requested
    
    return cell;
}

//UITableViewDelegate method that is called when a row is selected
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rowData=[continentData allKeys]; //creates an aray with all keys from our dictionary
    NSString *rowValue=[rowData objectAtIndex:indexPath.row]; //sets the title of the selected row
    NSString *message=[[NSString alloc] initWithFormat:@"You selected %@", rowValue];
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"Row Selected" message:message delegate:nil
                        cancelButtonTitle:@"Yes, I did" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //deselects the row that had been chosen
}

@end
