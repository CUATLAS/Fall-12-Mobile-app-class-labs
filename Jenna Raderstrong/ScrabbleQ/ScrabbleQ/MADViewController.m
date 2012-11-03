//
//  MADViewController.m
//  ScrabbleQ
//
//  Created by Jenna Raderstrong on 10/23/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController () {
    NSDictionary *words;
    NSArray *letters;
}

@end

@implementation MADViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle= [NSBundle mainBundle]; //returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"qwordswithoutu" ofType:@"plist"]; //retrieve the path of continents.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];//loads contents of plist
    words=dictionary;
    NSArray *array=[[words allKeys] sortedArrayUsingSelector:@selector(compare:) ];
    letters=array;
    self.title=@"Words";
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [letters count]; //each letter is a section
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *letter=[letters objectAtIndex:section];//gets the letter for the chosen section
    NSArray *letterSection=[words objectForKey:letter]; //gets the word for that section
    return [letterSection count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section=[indexPath section];//gets the section
    NSUInteger row=[indexPath row]; //gets the row
    NSString *letter=[letters objectAtIndex:section]; //gets the letter of the requested section
    NSArray *wordSection=[words objectForKey:letter]; //gets the words for that section
    
    static NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell== nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
    }
    //Configure the cell
    cell.textLabel.text=[wordSection objectAtIndex:row]; 
    
   
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *letter=[letters objectAtIndex:section];
    return letter; 
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView
                                            *)tableView{
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
