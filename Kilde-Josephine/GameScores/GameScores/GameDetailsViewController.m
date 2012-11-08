//
//  GameDetailsViewController.m
//  GameScores
//
//  Created by  on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameDetailsViewController.h"

@interface GameDetailsViewController ()

@end

@implementation GameDetailsViewController
@synthesize nameTextField;
@synthesize delegate;

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
    [self.delegate gameDetailsViewControllerDidCancel:self];
}
-(IBAction)done:(id)sender{
    NSString *newGame=[[NSString alloc]initWithString:nameTextField.text];
    [self.delegate gameDetailsViewController:self DidSave:newGame];

}


@end
