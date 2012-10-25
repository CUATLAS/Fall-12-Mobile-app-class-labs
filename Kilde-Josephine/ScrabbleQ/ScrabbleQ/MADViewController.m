//
//  MADViewController.m
//  ScrabbleQ
//
//  Created by  on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController (){
    NSDictionary *words;
    NSArray *letters;
}



@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle=[NSBundle mainBundle]; //Returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"qwordswithoutu" ofType:@"plist"]; //Retrieve the path of the continents.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath]; //Loads the contents of the plist file into a dictionary
    //The dictionary uses the continents as the keys and a NSArray with the countires for each continent
    words=dictionary;
    NSArray *array=[[words allKeys] sortedArrayUsingSelector:@selector(compare:)]; //Grabs alll keys and sorts them to create an ordered array with all the values in alphabeltical order
    letters=array;
    self.title=@"Words"; //Sets the title of the controller
    
}

//UITableViewDataSource method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [letters count]; //Each letter will be a section
}

//Calculates the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
    NSString *letter=[letters objectAtIndex:section]; //Gets the letter for the chosen section
    NSArray *letterSection=[words objectForKey:letter]; //Gets the words for that letter
    return [letterSection count]; //Returns the number of words in that section
}

//Returns the requested cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section=[indexPath section]; //Gets the section
    NSUInteger row=[indexPath row]; //Gets the row
    NSString *letter=[letters objectAtIndex:section]; //Gets the letter of the requested section
    NSArray *wordsSection=[words objectForKey:letter]; //Gets the words for that section
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Configure the cell
    cell.textLabel.text=[wordsSection objectAtIndex:row];
    return cell;
}

//Sets the header value for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *letter=[letters objectAtIndex:section];
    return letter;
}

//Adds a section index
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return letters;
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

@end
