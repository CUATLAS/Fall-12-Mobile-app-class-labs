//
//  MADViewController.m
//  Hello_World_3
//
//  Created by Scott Serafin on 9/4/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize name_field;
@synthesize message_field;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setName_field:nil];
    [self setMessage_field:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)text_field_done_editing:(id)sender {
    [sender resignFirstResponder];
    NSString *message = [[NSString alloc] initWithFormat:@"Hello, %@!",name_field.text];
    message_field.text=message;
}
@end
