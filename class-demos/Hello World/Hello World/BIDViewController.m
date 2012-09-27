


//
//  BIDViewController.m
//  Hello World
//
//  Created by Aileen Pierce on 7/6/12.
//  Copyright (c) 2012 University of Colorado at Boulder. All rights reserved.
//

#import "BIDViewController.h"

@interface BIDViewController ()
@end

@implementation BIDViewController
@synthesize messageText;

- (void)viewDidLoad
{
[super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
[self setMessageText:nil];
[super viewDidUnload];
// Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonPressed:(UIButton *)sender {
NSString *title = [sender titleForState:UIControlStateNormal];
messageText.text = [NSString stringWithFormat:@"%@ World", title];
}
@end
