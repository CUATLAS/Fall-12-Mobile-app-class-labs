//
//  GameDetailsViewController.m
//  GameScores
//
//  Created by Aaron Vimont on 11/8/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "GameDetailsViewController.h"

@interface GameDetailsViewController ()

@end

@implementation GameDetailsViewController
@synthesize delegate;
@synthesize nameTextField;
@synthesize scoreTextField;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setScoreTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender {
    [self.delegate gameDetailsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    NSString *newGame = [[NSString alloc] initWithString:nameTextField.text];
    NSString *score = [[NSString alloc] initWithString:scoreTextField.text];
    if ([score isEqualToString:@""]) {
        score = @"0";
    }
    [self.delegate gameDetailsViewController:self DidSave:newGame WithScore:score];
}

@end