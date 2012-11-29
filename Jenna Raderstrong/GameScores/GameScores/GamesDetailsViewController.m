//
//  GamesDetailsViewController.m
//  GameScores
//
//  Created by Jenna Raderstrong on 11/27/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "GamesDetailsViewController.h"

@interface GamesDetailsViewController ()

@end

@implementation GamesDetailsViewController
@synthesize nameTextField;

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)cancel:(id)sender{
    [self.delegate gamesDetailsViewControllerDidCancel:self];
}
-(IBAction)done:(id)sender{
        NSString *newGame=[[NSString alloc]initWithString:nameTextField.text];
        [self.delegate gamesDetailsViewController:self DidSave:newGame];
    }
    


@end






