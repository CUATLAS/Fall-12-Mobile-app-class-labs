//
//  MADViewController.m
//  helloWorld2_final
//
//  Created by Rachel Strobel on 9/13/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize messageTextHello;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMessageTextHello:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)ButtonPress:(UIButton *)sender {
    NSString *title=[sender titleForState:UIControlStateNormal];
    messageTextHello.text=[NSString stringWithFormat:@"%@ World", title];
    
}

@end
