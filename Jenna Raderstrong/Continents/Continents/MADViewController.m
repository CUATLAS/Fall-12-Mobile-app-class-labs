//
//  MADViewController.m
//  Continents
//
//  Created by Jenna Raderstrong on 10/23/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController () {
    NSDictionary *continentData;
}

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle= [NSBundle mainBundle]; //returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"continents" ofType:@"plist"]; //retrieve the path of continents.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];//loads contents of plist
    continentData=dictionary;
    self.title=@"Continents";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    continentData=nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//Customize the the number of rows in the table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [continentData count]; //returns number of continents
}

//Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell== nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier ];
    }
    //Configure the cell
    //UIImage *world= [UIImage imageNamed:@"world.png"];
    //cell.imageView.image=world;
    cell.imageView.image= [UIImage imageNamed:@"world.png"];
    cell.detailTextLabel.text=@"Earth";
    
    NSArray *rowData=[continentData allKeys]; //create an array with all keys from dictionary
    cell.textLabel.text=[rowData objectAtIndex:indexPath.row]; //sets the text of the cell with the row being requested
    
    return cell;
}

//UITableViewDelegate method that is called whena  row is selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rowData=[continentData allKeys];//creates an array with all keys from our dictionary
    NSString *rowValue=[rowData objectAtIndex:indexPath.row]; //sets the title of the selected row
    NSString *message=[[NSString alloc] initWithFormat:@"You Selected %@.", rowValue];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Row Selected" message:message delegate:nil cancelButtonTitle:@"Yes, I did" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //deselects the row that had been chosen
}


@end














