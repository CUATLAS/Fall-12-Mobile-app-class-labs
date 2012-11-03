//
//  MADViewController.m
//  helloWorld2
//
//  Created by Aaron Vimont on 9/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize halsMessage;
@synthesize shutHalDown;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setHalsMessage:nil];
    [self setShutHalDown:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)sayHello:(UIButton *)sender {
    [halsMessage setAlpha:1];
    halsMessage.text = [NSString stringWithFormat:@"Hello, Dave"];
}

- (IBAction)sayGoodbye:(UIButton *)sender {
    [halsMessage setAlpha:1];
    halsMessage.text = [NSString stringWithFormat:@"What are you doing, Dave?"];
    [shutHalDown setAlpha:1];
}

- (IBAction)shutItDown:(UIButton *)sender {
    halsMessage.text = [NSString stringWithFormat:@"Please stop..."];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3.0];
    [halsMessage setAlpha:0];
    [UIView commitAnimations];
    [shutHalDown setAlpha:0];
    
}
@end
