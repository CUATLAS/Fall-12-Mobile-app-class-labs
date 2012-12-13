//
//  TasksViewController.m
//  Tasks
//
//  Created by Stephen Feuerstein on 11/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "TasksViewController.h"
#import "Task.h"
#import "AddTaskViewController.h"

@interface TasksViewController ()

-(void)fetchTasks;

@end

@implementation TasksViewController

-(void)fetchTasks
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSDictionary *queryParameters =[NSDictionary dictionaryWithObjectsAndKeys:@"2", @"user_id", nil];
    RKURL *URL = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/tasks.json" queryParameters:queryParameters];
    [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [URL resourcePath], [URL query]] delegate:self];
}

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
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchTasks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Task *task = [self.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.name;
    
    if (task.complete) {
        cell.detailTextLabel.text = @"Complete";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        cell.detailTextLabel.text = [dateFormatter stringFromDate:task.dueDate];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    [self.refreshControl endRefreshing];
    NSLog(@"Error: %@", [error localizedDescription]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not fetch tasks. Please try again later." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
{
    [self.refreshControl endRefreshing];
    NSLog(@"Response Code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    if (objectLoader.response.statusCode == 204) {
        [self fetchTasks];
    } else {
        self.tasks = objects;
        [self.tableView reloadData];
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[Task class]]) {
        AddTaskViewController *addViewController = ((UINavigationController *)segue.destinationViewController).viewControllers[0];
        addViewController.title = @"Edit Task";
        addViewController.task = sender;
    }
}

@end
