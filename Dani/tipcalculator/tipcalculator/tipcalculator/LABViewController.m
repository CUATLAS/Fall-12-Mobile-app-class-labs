//
//  LABViewController.m
//  tipcalculator
//
//  Created by new user on 10/10/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import "LABViewController.h"

@interface LABViewController ()

@end

@implementation LABViewController
@synthesize checkAmount;
@synthesize tipPercent;
@synthesize people;
@synthesize tipDue;
@synthesize totalDue;
@synthesize totalDuePerPerson;

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkAmount.delegate=self;
    tipPercent.delegate=self;
    people.delegate=self;
    //viewDidLoad is called automatically after the views have been initialized but before it's displayed.
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES; // textFieldShouldReturn: is sent to the UITextField's delegate when the return button on the keyboard is pressed
}
-(void)updateTipTotals
{
    //get the values from the text fields
    //floatValue returns a float, intValue returns an int
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    
    pct=pct/100; //Convert to a fraction
    //compute the totals
    float tip=amount*pct;
    float total=amount+tip;
    float personTotal=0;
    
    //handles divide by 0 error
    if (numberOfPeople>0)
    {
        personTotal=total/numberOfPeople;
    }
    else { //am alert will show if numberOfPeople is 0
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Warning"
                                message: @"The number of people must be greater than 0"
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"OK",nil]; // list must always end in nil
        [alertView show];
    }
    
    //Use NSNumberFormatter to set the format style to currency
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    //update the labels
    //stringFromNumber: generates strings
    tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTipTotals];
}
-(void)alertView:(UIAlertView*)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) //OK button
    {
        people.text=[NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}
@end
