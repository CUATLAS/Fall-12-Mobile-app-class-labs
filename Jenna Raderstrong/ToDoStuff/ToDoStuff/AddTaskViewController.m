//
//  AddTaskViewController.m
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/10/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
@synthesize taskTextField, delegate, selection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       taskTextField.text=[selection objectForKey:@"object"];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTaskTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([delegate respondsToSelector:@selector(setEditedSelection:)]) {
        [taskTextField endEditing:YES];
        if(taskTextField.text.length>0){
        NSIndexPath *indexPath = [selection objectForKey:@"indexPath"];
        id object = taskTextField.text;
        NSDictionary *editedSelection = [NSDictionary dictionaryWithObjectsAndKeys: indexPath, @"indexPath",object, @"object", nil];
        [delegate setValue:editedSelection forKey:@"editedSelection"];
        }
    }
}

@end











