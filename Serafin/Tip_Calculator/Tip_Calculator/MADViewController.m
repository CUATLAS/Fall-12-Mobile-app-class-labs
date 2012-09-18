//
//  MADViewController.m
//  Tip_Calculator
//
//  Created by Scott Serafin on 9/18/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize check_amount;
@synthesize tip_percent;
@synthesize people;
@synthesize tip_total;
@synthesize bill_total;
@synthesize per_person_total;

- (void)viewDidLoad
{
    [super viewDidLoad];
    check_amount.delegate = self;
    tip_percent.delegate = self;
    people.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCheck_amount:nil];
    [self setTip_percent:nil];
    [self setPeople:nil];
    [self setTip_total:nil];
    [self setBill_total:nil];
    [self setPer_person_total:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


// Allows the "Return" button to be used
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[textField resignFirstResponder];
    
    // Switch from text field to text field with the "NEXT" button
    
    if(textField == check_amount)
    {
        [tip_percent becomeFirstResponder];
    }
    if(textField == tip_percent)
    {
        [people becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

// Tip Calculation
- (void)update_tip_totals
{
    // Get the values from the text fields
    float amount = [check_amount.text floatValue];
    float pct = [tip_percent.text floatValue];
    int num_people = [people.text intValue];
    
    // Convert Tip to a Fraction
    pct = pct/100;
    
    // Compute the totals
    float tip = amount*pct;
    float total = amount + tip;
    float person_total = 0;
    
    // Fix dividing by zero
    if (num_people > 0)
    {
        person_total = total / num_people;
    }
    else
    {
        // Show an alert to the user
        UIAlertView *alertView=[[UIAlertView alloc]
                                 initWithTitle:@"Ummm..."
                                 message: @"Who is supposed to pay for the bill if no one is there?"
                                 delegate:self  // If one button set to nil
                                 cancelButtonTitle:@"Cancel"
                                 otherButtonTitles:@"OK, nil"
                                ];  // the list must always end with nil
                                        // If no other buttons set to nil
        [alertView show];
        
    }
    
    // Format the values to look like currency
    NSNumberFormatter *currency_format = [[NSNumberFormatter alloc]init];
    [currency_format setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // Update the labels
    tip_total.text = [currency_format stringFromNumber: [NSNumber numberWithFloat:tip]];
    bill_total.text = [currency_format stringFromNumber: [NSNumber numberWithFloat:total]];
    per_person_total.text = [currency_format stringFromNumber: [NSNumber numberWithFloat:person_total]];
    
}

// Finished typing in the text field?  Update the tip
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self update_tip_totals];
}

// Close the text editor when a click is outside of a text field
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)calculate:(id)sender {
    [self update_tip_totals];
    [self.view endEditing:YES];
}
   
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) // OK Button
    {
        people.text=[NSString stringWithFormat:@"1"];
        [self update_tip_totals];
    }
}
                                
                                
@end
