//
//  MADViewController.m
//  tipcalculator
//
//  Created by Elise J Beall on 9/18/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize totalDuePerPerson;
@synthesize totalDue;
@synthesize tipDue;
@synthesize people;
@synthesize tipPercent;
@synthesize checkAmount;

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkAmount.delegate=self;
    tipPercent.delegate=self;
    people.delegate=self;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)updateTipTotals
{
    //get the values from the text fields
    //floatValue returns a floatm intValue returns an int
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    //convert to a fraction
    pct=pct/100;
    //compute the totals
    float tip=amount*pct;
    float total=amount+tip;
    float personTotal=0;
    //handles divide by 0 error
    if (numberOfPeople>0)
    {
        personTotal=total/numberOfPeople;
    }
    
    else { //an alert will show if numberOfPeople is 0
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Warning"
                                message: @"The number of people must be greater than 0" delegate: self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"OK", nil]; //list must always end in nil
        [alertView show];
    }
    
    //use NSNumberFormatter to set the format style to currency
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    //update the labels
    //stringFromNumber: generates strings
    tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}

-(IBAction)backgroundClick:(id)sender
{
    [checkAmount resignFirstResponder];
    [tipPercent resignFirstResponder];
    [people resignFirstResponder];
}

- (IBAction)calculate:(id)sender {
    [self updateTipTotals];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) //OK button
    {
        people.text=[NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}

@end
