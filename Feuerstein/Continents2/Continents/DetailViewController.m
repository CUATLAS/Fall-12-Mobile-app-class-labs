//
//  DetailViewController.m
//  Continents
//
//  Created by Stephen Feuerstein on 10/30/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize countryList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(id)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:style]))
    {
        // Custom init style
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.editing)
        return (countryList.count + 1); // adds 1 if editing
    
    return countryList.count;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    cellLabelText = textField.text;
    //return YES;
}

// Custom table view cells
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    BOOL addCell = (indexPath.row == countryList.count); // returns YES if adding row
    
    if (addCell)
        cellIdentifier = @"AddCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    // Set text if adding a new cell
    if (addCell)
    {
        cell.textLabel.text = @"Add a new country";
    }
    else
        cell.textLabel.text = [countryList objectAtIndex:indexPath.row];
    
    return cell;
}

// Sets editing style
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == countryList.count)
    {
        return UITableViewCellEditingStyleInsert;
    }
    else
        return UITableViewCellEditingStyleDelete;
}

// Called after edits
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deleting
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [countryList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // Adding
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        NSString *newItem;
        
        if (indexPath.row == 6)
            newItem = @"Still adding countries?";
        else
            newItem = @"New Country";
        [countryList insertObject:newItem atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        // Reloads data to add new country
        [tableView reloadData];
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if (editing)
    {
        // Animate left and update for inserting
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    }
    else
    {
        // Animate right and update for deleting
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:countryList.count inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
}

// Moving rows
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSUInteger sourceRow = [sourceIndexPath row];
    NSUInteger destinationRow = [destinationIndexPath row];
    NSString *moveCountry = [countryList objectAtIndex:sourceRow];
    
    if (destinationRow < countryList.count)
    {
        [countryList removeObjectAtIndex:sourceRow];
        [countryList insertObject:moveCountry atIndex:destinationRow];
    }
    // Move to end of list
    else
    {
        [countryList removeObjectAtIndex:sourceRow];
        [countryList insertObject:moveCountry atIndex:countryList.count];
    }
    
    [self.tableView reloadData];
}

// Enable row moving
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < countryList.count)
        return YES;
    return NO;
}

// Row selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end