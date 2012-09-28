//
//  HWLViewController.m
//  Tip Calulator
//
//  Created by  on 9/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize checkAmount;
@synthesize tipPercent;
@synthesize people;
@synthesize tipDue;
@synthesize totalDue;
@synthesize totalDuePerPerson;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    checkAmount.delegate = self;
    tipPercent.delegate = self;
    people.delegate = self;
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

- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)updateTipTotals
{
    //get the values from text fields
    //floatvalue returns a float, intValue returns an intiger
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    //convert to fraction
    pct=pct/100;
    float tip=amount*pct;
    float total=amount+tip;
    float personTotal=0;
    //handles divide by 0 error
    if (numberOfPeople>0)
    {
        personTotal=total/numberOfPeople;
    }
    else {//an alert will show if numberOfPeople is 0
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Warning" message:@"The number of people must be greater than zero" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    //use NSNumber formatter to set the format to currency
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    //update the labels 
    //StringFromNumber: generates strings
    tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
    
}

-(void)textFieldDidEndEditing: (UITextField *) textField
{
    [self updateTipTotals];
}

-(void)alertView: (UIAlertView *)alertView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{   
    if (buttonIndex==1) {
        people.text=[NSString stringWithFormat:@"1"];
        [self updateTipTotals];    
    }
}

@end
