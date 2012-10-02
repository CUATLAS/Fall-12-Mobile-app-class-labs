//
//  MADViewController.m
//  tipCalculator
//
//  Created by Jenna Raderstrong on 9/18/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{[textField resignFirstResponder];
    return YES;
}
-(void)updateTipTotals {
    //get the calculations from the text fields
    //floatValue returns a float intValue returns an int
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    //convert to fraction
    pct=pct/100;
    //compute total
    float tip=amount*pct;
    float total=amount+tip;
   float personTotal=total/numberOfPeople;
        
       //handles divide by zero error
  
 //use NSNumberFormatter to set the format style to currency
NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//update labels
//stringFromNumber: generator strings
tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];

}
/*-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTipTotals];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{if(buttonIndex==1)//OK Button
    people.text=[NSString stringWithFormat:@"1"];
    [self updateTipTotals];
}*/
- (IBAction)calculateButton:(id)sender {
    bool allFilled=NO;
    bool goodValues=NO;
    
    if([checkAmount.text length]>0 && [tipPercent.text length] > 0 && [people.text length] > 0)
    { allFilled=YES;}
    if ( [checkAmount.text floatValue] >0 && [tipPercent.text floatValue] > 0 && [people.text floatValue] > 0){
        goodValues=YES;}
    if (goodValues==YES && allFilled==YES){
        [self updateTipTotals];
    }
    
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning"message:@"One of Your Entries is 0 :Cannot Compute."delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];//lit always ends with nil
        [alertView show];
    }}
@end












