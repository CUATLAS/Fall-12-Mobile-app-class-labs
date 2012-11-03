//
//  ViewController.m
//  ScrabbleQ
//
//  Created by Scott Serafin on 10/23/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSDictionary *words;
    NSArray *letters;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"qwords" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    words = dictionary;
    NSArray *array = [[words allKeys] sortedArrayUsingSelector:@selector(compare:)];
    letters = array;
    self.title = @"Q Words Without U";  // Sets the title of the Table View
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *) tableView
{
    return [letters count];  // each letter will be a section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *letter = [letters objectAtIndex:section];  // gets the lettr of the chosen section
    NSArray *letterSection = [words objectForKey:letter];  // gets the words for that letter
    return [letterSection count];  //return number of word for that section
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *letter = [letters objectAtIndex:section];
    NSArray *wordsSection = [words objectForKey: letter];
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [wordsSection objectAtIndex:row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *letter = [letters objectAtIndex:section];
    return letter;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
