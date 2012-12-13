//
//  AddTaskViewController.m
//  Tasks
//
//  Created by Stephen Feuerstein on 11/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "AddTaskViewController.h"
#import "TextFieldCell.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

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

    self.cancelButton.target = self;
    self.cancelButton.action = @selector(dismissModalViewControllerAnimated:);
    
    self.saveButton.target = self;
    
    if (self.task)
    {
        self.saveButton.action = @selector(putTask);
    }
    else
    {
        self.saveButton.action = @selector(postTask);
        self.task = [[Task alloc] init];
        self.task.userId = [NSNumber numberWithInteger:2];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TKTaskAddViewController

- (void)putTask
{
    [self.view endEditing:YES];
    [[RKObjectManager sharedManager] putObject:self.task delegate:self];
}

- (void)postTask
{
    [self.view endEditing:YES];
    [[RKObjectManager sharedManager] postObject:self.task delegate:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (TextFieldCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TextFieldCell";
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textField.delegate = self;
    cell.textField.text = self.task.name;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not post task. Please try again later." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
{
    NSLog(@"Response Code: %d", [response statusCode]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.task.name = textField.text;
}


@end
