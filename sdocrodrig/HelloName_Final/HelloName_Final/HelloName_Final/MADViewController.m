//
//  MADViewController.m
//  HelloName_Final
//
//  Created by new user on 9/19/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@property (copy, nonatomic) NSString *userName;

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
        NSString *message = [[NSString alloc] initWithFormat:@"Nice to see you, %@", nameField.text];
        messageField.text=message;
}
@end
