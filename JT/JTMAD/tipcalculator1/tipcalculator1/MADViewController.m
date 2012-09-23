//
//  MADViewController.m
//  tipcalculator1
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)updateTipTotals
{
    //get the values from the text fields
    //floatValue returns a float, inValue returns an int
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    //Convert to a fraction
    pct=pct/100;
    //compute the totals
    float tip=amount*pct;
    float total=amount+tip;
    float personTotal=0;
    //hand divide by 0 error
    if (numberOfPeople>0)
    {
        personTotal=total/numberOfPeople;
    }
    else { //an alert will show if numberOfPeople is 0
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Waring"
                                message: @"The number of people must be greater than 0"
                                delegate:self //for one button put nil
                                cancelButtonTitle:@"Cancel"// get rid of for one button
                                otherButtonTitles:@"OK", nil]; //list must always end in nil.
        [alertView show];
    }
    //use NSNumberFormatter to set the format style to currency
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    //update the labels
    //ustring nonNumber: generates Strings
    tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{ 
    [self updateTipTotals];
}

//no code needed below for just one button. 
-(void)alertViewCancel:(UIAlertView *)alertView didDismissWithButtonIndex: (NSInteger)buttonIndex
{
    if (buttonIndex==1) //Ok button
    {
        people.text=[NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}








@end
