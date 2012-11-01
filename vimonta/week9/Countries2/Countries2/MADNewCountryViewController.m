//
//  MADNewCountryViewController.m
//  Countries2
//
//  Created by Aaron Vimont on 10/30/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADNewCountryViewController.h"

@interface MADNewCountryViewController ()

@end

@implementation MADNewCountryViewController
@synthesize theNewCountryName;
@synthesize countryInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTheNewCountryName:nil];
    countryInfo = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    countryInfo.countryName = theNewCountryName.text;
    
    // dismisses the info view and flips back to the favorites view
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// dismisses keyboard when the user touches outside of the textview
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([theNewCountryName isFirstResponder] && [touch view] != theNewCountryName) {
        [theNewCountryName resignFirstResponder];
    }
}
@end
