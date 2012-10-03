//
//  HWLViewController.m
//  Mileage Calculator
//
//  Created by  on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize initialMileage;
@synthesize currentMileage;
@synthesize cost;
@synthesize gallonsFilled;
@synthesize dollarsPerMile;
@synthesize milesPerGallon;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    initialMileage.delegate=self;
    currentMileage.delegate=self;
    cost.delegate=self;
    gallonsFilled.delegate=self;
}

- (void)viewDidUnload
{
    [self setInitialMileage:nil];
    [self setCost:nil];
    [self setGallonsFilled:nil];
    [self setDollarsPerMile:nil];
    [self setMilesPerGallon:nil];
    [self setCurrentMileage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)updateMilesPerGallon
{
    //get the values from the text fields
    //floatvalue returns a float, intValue retunrs an intiger
    float totalFuel=[gallonsFilled.text floatValue];
    float oldMileage=[initialMileage.text floatValue];
    float newMileage=[currentMileage.text floatValue];
    float mileagePerGallon=0;
    
    float totalMileage=newMileage-oldMileage;
    //handles divide by 0 
    if (totalFuel>0)
    {
       mileagePerGallon=totalMileage/totalFuel; 
    }
    else {
        UIAlertView *alertView= [[UIAlertView alloc]
        initWithTitle:@"Warning" message:@"The Gallons Filled Field Cannot be Zero" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    
    NSNumberFormatter *mileageFormatter=[[NSNumberFormatter alloc]init];
    [mileageFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    //update the labels 
    //StringFromNumber: generates strings
    milesPerGallon.text=[mileageFormatter stringFromNumber:[NSNumber numberWithFloat:mileagePerGallon]];
    
    NSString *message = [[NSString alloc] initWithFormat: milesPerGallon.text, @"Hello, %@"];
    milesPerGallon.text=message;
}

- (IBAction)textFieldDoneEditing:(UITextField *)sender {[sender resignFirstResponder];
    NSString *message = [[NSString alloc] initWithFormat:@"Hello, %@", milesPerGallon.text];
    milesPerGallon.text=message;
}

-(void)textFieldDidEndEditing: (UITextField *) textField
{
    [self updateMilesPerGallon];
}

-(void)alertView: (UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex
{   
    if (buttonIndex==1) {
        gallonsFilled.text=[NSString stringWithFormat:@"1"];
        [self updateMilesPerGallon];    
    }
}




@end
