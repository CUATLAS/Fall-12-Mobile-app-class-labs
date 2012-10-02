//
//  HWLViewController.m
//  Mileage Calculator
//
//  Created by  on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize initialMileage;
@synthesize currentMileage;
@synthesize cost;
@synthesize gallonsFilled;
@synthesize dollarsPerMile;
@synthesize milesPerGallon;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    initialMileage.delegate=self;
    currentMileage.delegate=self;
    cost.delegate=self;
    gallonsFilled.delegate=self;
}

- (void)viewDidUnload
{
    [self setInitialMileage:nil];
    [self setCost:nil];
    [self setGallonsFilled:nil];
    [self setDollarsPerMile:nil];
    [self setMilesPerGallon:nil];
    [self setCurrentMileage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
