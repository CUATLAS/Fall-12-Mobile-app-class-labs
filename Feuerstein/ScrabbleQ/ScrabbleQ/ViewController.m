//
//  ViewController.m
//  ScrabbleQ
//
//  Created by Stephen Feuerstein on 10/23/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"qwordswithoutu" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    wordsDict = dict;
    letters = [[wordsDict allKeys] sortedArrayUsingSelector:@selector(compare:)]; // Sorts alphabetically
    self.title = @"Words";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [letters count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *letter = [letters objectAtIndex:section];
    NSArray *letterSection = [wordsDict objectForKey:letter]; // section of words with letter
    return [letterSection count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    NSString *letter = [letters objectAtIndex:section];
    NSArray *wordsSection = [wordsDict objectForKey:letter];
    
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    // Configure cell
    cell.textLabel.text = [wordsSection objectAtIndex:row];
    
    return cell;
}

// Section headers
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [letters objectAtIndex:section];
}

// Add section index
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return letters;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    wordsDict = nil;
    letters = nil;
}

@end
