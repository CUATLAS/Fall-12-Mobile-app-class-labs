//
//  HWLViewController.m
//  ScrabbleQ
//
//  Created by  on 10/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController () {
    NSDictionary *words;
    NSArray *letters;
}

@end

@implementation HWLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"qwordswithoutu" ofType:@"plist"];
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    words=dictionary;
    NSArray *array=[[words allKeys] sortedArrayUsingSelector:@selector(compare:)];
    letters=array;
    self.title=@"words";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [letters count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *letter=[letters objectAtIndex:section];
    NSArray *letterSection=[words objectForKey:letter];
    return [letterSection count];
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section=[indexPath section];
    NSUInteger row=[indexPath row];
    NSString *letter = [letters objectAtIndex:section];
    NSArray *wordsSection=[words objectForKey:letter];
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[wordsSection objectAtIndex:row];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *letter= [letters objectAtIndex:section];
    return letter;
}

-(NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    return letters;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    words=nil;
    letters=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
