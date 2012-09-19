//
//  MADViewController.m
//  Tip Calculator
//
//  Created by James Mason on 9/18/12.
//  Copyright (c) 2012 Trinary. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize checkAmount, tipPercent, numberOfPeople, tipDue, totalDue, totalDuePerPerson;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    checkAmount.delegate = self;
    tipPercent.delegate = self;
    numberOfPeople.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidUnload
{
    [self setCheckAmount:nil];
    [self setTipPercent:nil];
    [self setNumberOfPeople:nil];
    [self setTipDue:nil];
    [self setTotalDue:nil];
    [self setTotalDuePerPerson:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard
{
    [numberOfPeople resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTipTotals];
}

- (void)updateTipTotals
{
    // Get the values from the text fields
    float checkAmountFloat = [checkAmount.text floatValue];
    float percentFloat = [tipPercent.text floatValue];
    int numberOfPeopleInt = [numberOfPeople.text intValue];
    
    // Convert percentage to a fraction
    percentFloat = percentFloat / 100;
    
    // Compute the totals
    float tip = checkAmountFloat * percentFloat;
    float total = checkAmountFloat + tip;
    float personTotal = 0;
    
    // Handles divide by 0 error
    if (numberOfPeopleInt > 0) {
        personTotal = total / numberOfPeopleInt;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"YOU DUMMY!"
                                                        message:@"Really? No one ate the food?!"
                                                       delegate:self cancelButtonTitle:@"Whatever!"
                                              otherButtonTitles:@"I'm Dumb", nil];
        [alert show];
    }
    
    // Use NSNumberFormatter to convert format to currency style
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // Update the output labels
    tipDue.text = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) { // index 1 is the second button
        numberOfPeople.text = [NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}

@end
