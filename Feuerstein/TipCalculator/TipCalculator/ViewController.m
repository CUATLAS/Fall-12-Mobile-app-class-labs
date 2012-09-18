//
//  ViewController.m
//  TipCalculator
//
//  Created by Stephen Feuerstein on 9/18/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize checkAmountField, tipPercentField, numPeopleField;
@synthesize tipLabel, totalLabel, perPersonLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkAmountField.delegate = self;
    tipPercentField.delegate = self;
    numPeopleField.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    
    numPeopleField.text = @"1";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
// Returns out the keyboard
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTipAmounts];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Resign keyboard if touch detected outside a text field
    [self.view endEditing:YES];
    [self updateTipAmounts];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) // OK
    {
        numPeopleField.text = @"1";
        [self updateTipAmounts];
    }
}

-(void)updateTipAmounts
{
    float checkAmount = [checkAmountField.text floatValue];
    float tipPercent = [tipPercentField.text floatValue];
    int numPeople = [numPeopleField.text intValue];
    
    // Convert tip % to %
    tipPercent = tipPercent/100;
    
    // Raise alert if number of people is less than 1
    if (numPeople < 1)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Warning"
                              message:@"Number of people must be more than 0"
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        // Calculate and update labels
        float tip = checkAmount * tipPercent;
        float total = checkAmount + tip;
        float perPersonTotal = total / numPeople;
        tipLabel.text = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
        totalLabel.text = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
        perPersonLabel.text = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:perPersonTotal]];
        
        // Right justify
        tipLabel.textAlignment = kCTRightTextAlignment;
        totalLabel.textAlignment = kCTRightTextAlignment;
        perPersonLabel.textAlignment = kCTRightTextAlignment;
    }
}

@end
