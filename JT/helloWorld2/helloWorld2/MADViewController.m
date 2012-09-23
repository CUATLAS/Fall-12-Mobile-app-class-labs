//
//  MADViewController.m
//  helloWorld2
//
//  Created by John Birchall on 9/16/12.
//  Copyright (c) 2012 John Birchall. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize nameField;
@synthesize messageField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNameField:nil];
    [self setMessageField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
    NSString *message = [[NSString alloc] initWithFormat:@"Hello, %@", nameField.text];
    messageField.text=message;
}

@end
