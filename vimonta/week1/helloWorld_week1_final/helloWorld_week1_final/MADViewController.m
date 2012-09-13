//
//  MADViewController.m
//  helloWorld_week1_final
//
//  Created by Aaron Vimont on 9/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize messageField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMessageField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonClicked:(UIButton *)sender {
    [messageField setAlpha:1];
    messageField.text = [NSString stringWithFormat:@"Hello Dave. I'll see you soon..."];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:5.0];
    [messageField setAlpha:0];
    [UIView commitAnimations];
}
@end
