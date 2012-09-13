//
//  MADViewController.m
//  helloName
//
//  Created by Aaron Vimont on 9/4/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize nameField;
@synthesize messageField;
@synthesize whereFrom;
@synthesize whereFromInputField;
@synthesize lovely;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidUnload
{
    [self setNameField:nil];
    [self setMessageField:nil];
    [self setWhereFrom:nil];
    [self setWhereFromInputField:nil];
    [self setLovely:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) dismissKeyboard {
    [nameField resignFirstResponder];
    [whereFromInputField resignFirstResponder];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
    NSString *message = [[NSString alloc] initWithFormat:@"Hello, %@", nameField.text];
    messageField.text = message;
    [whereFrom setAlpha:1];
    [whereFromInputField setAlpha:1];
}
- (IBAction)whereFromDoneEditing:(UITextField *)sender {
    [sender resignFirstResponder];
    [lovely setAlpha:1];
}
@end
