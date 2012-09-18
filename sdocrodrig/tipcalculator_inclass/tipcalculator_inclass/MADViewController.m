//
//  MADViewController.m
//  tipcalculator_inclass
//
//  Created by new user on 9/18/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
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
	// Step 3: Add delegates (ceckAmount/tipPercent/people) in viewDidLoad and keyboard will go away when enter is pressed
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
// Step 2: 
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    // When hit return, the keyboard goes away
    
// Step 4: Create own method DidEndEditing (gets called when someone is done typing and calls method TipTotals)
    // Any method going to call put above where call it
}

-(void)updateTipTotals
{
    // get the values from the text fields
    // floatValue returns a float, intValue returns an int
    // Defining two variables (primitive type)
    // Grabbing string, converting to a float and storing as an amount (dollar amount put in)
    // Text fields must be a string because Objective C is strongly typed
    float amount=[checkAmount.text floatValue];
    float pct=[tipPercent.text floatValue];
    int numberOfPeople=[people.text intValue];
    //Convert percent to a fraction by dividing by 100
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
    // else will take zero of and negative number
    else { // an alert with show if numberOfPeople is 0
        //allocating memory for UIAlertView for class UIAlertView
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Warning"
                                message:@"The number of people must be greater than 0"
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                // Done with list of buttons and must always end with nil
                                otherButtonTitles:@"OK", nil];
        // to appear on screen, send the show method
        [alertView show];
    }


    // use NSNumberFormatter to set the format style to currency
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        // telling number to have number style of currency

    //Floats and integers need to be converted back to strings
    tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
}

// Just created a method, now need to call it. Anytime a user clicks off a text field...
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTipTotals];
}

// If person presses ok, can't be zero, then going to make 1 automatically show up
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{ if(buttonIndex==1){
    people.text=[NSString stringWithFormat:@"1"];
    [self updateTipTotals];
}
}
@end
