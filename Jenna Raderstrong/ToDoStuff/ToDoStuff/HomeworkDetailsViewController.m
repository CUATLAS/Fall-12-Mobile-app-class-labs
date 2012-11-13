//
//  HomeworkDetailsViewController.m
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/11/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "HomeworkDetailsViewController.h"

@interface HomeworkDetailsViewController ()

@end

@implementation HomeworkDetailsViewController
@synthesize homeworkTextField;

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
    [self setHomeworkTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



-(IBAction)cancel:(id)sender{
    [self.delegate homeworkDetailsViewControllerDidCancel:self];
}
-(IBAction)done:(id)sender{
        NSString *newHomework=[[NSString alloc]initWithString:homeworkTextField.text];
        [self.delegate homeworkDetailsViewController:self DidSave:newHomework];
    }


@end






