//
//  ErrandDetailsViewController.m
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/12/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "ErrandDetailsViewController.h"

@interface ErrandDetailsViewController ()

@end

@implementation ErrandDetailsViewController
@synthesize errandTextField;

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
    [self setErrandTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


-(IBAction)cancel:(id)sender{
    [self.delegate errandDetailsViewControllerDidCancel:self];
}
-(IBAction)done:(id)sender{
    NSString *newErrand=[[NSString alloc]initWithString:errandTextField.text];
    [self.delegate errandDetailsViewController:self DidSave:newErrand];

}




@end
