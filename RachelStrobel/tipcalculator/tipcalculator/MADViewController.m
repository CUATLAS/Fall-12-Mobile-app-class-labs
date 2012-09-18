//
//  MADViewController.m
//  tipcalculator
//
//  Created by Rachel Strobel on 9/18/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
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

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    //This is a Delegate Return. When users click the return button, users will be notified.
}

-(void)updateTipTotals
{
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    pct=pct/100;
    float tip=amount*pct;
    float total=amount+tip;
    float personTotal=0;
    if (numberOfPeople>0)
    {
        personTotal=total/numberOfPeople;
    }
    
    else{
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Warning"
                                message: @"The number of people must be great than 0"
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTipTotals];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex: (NSInteger) buttonIndex
{
    if (buttonIndex==1)
    {
        people.text=[NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}

@end
