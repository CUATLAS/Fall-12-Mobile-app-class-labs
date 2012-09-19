//
//  MADViewController.m
//  tipcalculator
//
//  Created by  on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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

//Remove keypad when retun key is hit
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)updateTipTotals
{
    //Get the values from the text fields
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    
    //Convert to a fraction
    pct=pct/100;
    
    //Compute the totals
    float tip=amount*pct;
    float total=amount+tip;
    float personTotal=0;
    
    //Handles divide by 0 error
    if (numberOfPeople>0)
    {
        personTotal=total/numberOfPeople;
    }
    else {
        //An alert will show if numberOfPeople is 0
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Warning!"
                                message:@"The number of people must be greater than 0"
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"OK", nil]; //List must always end in nil
        [alertView show];
    }
    
    //Use NSNmberFormatter to set the format style to currency
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    //Update the labels
    //stringFromNumber: generates strings
    tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTipTotals];
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex==1) //OK button
    {
        people.text=[NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}

@end
