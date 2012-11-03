//
//  MADViewController.m
//  tipCalculator
//
//  Created by Aaron Vimont on 9/18/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize checkAmount;
@synthesize tipPercent;
@synthesize people;
@synthesize tipDue;
@synthesize totalDue;
@synthesize totalDuePerPerson;

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkAmount.delegate = self;
    tipPercent.delegate = self;
    people.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCheckAmount:nil];
    [self setTipPercent:nil];
    [self setPeople:nil];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self updateTipTotals];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)updateTipTotals {
    // get the values from the text fields
    // floatValue returns a float, intValue returns an int
    float amount = [checkAmount.text floatValue];
    float pct = [tipPercent.text floatValue];
    int numberOfPeople = [people.text intValue];
    
    // convert to a fraction
    pct = pct/100;
    
    // compute the totals
    float tip = amount * pct;
    float total = amount + tip;
    float personTotal = 0;
    
    // handles divide by 0 error
    if (numberOfPeople > 0) {
        personTotal = total/numberOfPeople;
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Choo Crazeh?!"
                                  message:@"Are you dining and dashing or did at least one person eat?"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Okay", nil]; // always end list o' buttons with nil
        [alertView show];
    }
    
    // use NSNumberFormatter to set the format style to currency
    NSNumberFormatter *currentFormatter = [[NSNumberFormatter alloc]init];
    [currentFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // update the labels
    // stringFromNumber: generates strings
    tipDue.text = [currentFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text = [currentFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text = [currentFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateTipTotals];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // Okay button
        people.text = [NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}

- (IBAction)stepperPressed:(UIStepper *)sender {
    // get stepper value and cast to int
    double stepperValue = sender.value;
    int intVal = (int)stepperValue;
    
    // change value of people
    people.text = [NSString stringWithFormat:@"%d", intVal];
    
    [self.view endEditing:YES]; // remove keyboard if present
    
    [self updateTipTotals];
}
@end
