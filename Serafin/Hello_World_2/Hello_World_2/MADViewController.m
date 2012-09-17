//
//  MADViewController.m
//  Hello_World_2
//
//  Created by Scott Serafin on 9/4/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize hello_text;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setHello_text:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)hello_button:(UIButton *)sender {
    // hello_text.text=@"Hello World!";
    
    NSString *title=[sender titleForState:UIControlStateNormal];
    // ^this will set title to either hello or goodbye depending on which button was pressed
    hello_text.text=[NSString stringWithFormat:@"%@ World", title];
    // %@ grabs a string variable
}
@end
