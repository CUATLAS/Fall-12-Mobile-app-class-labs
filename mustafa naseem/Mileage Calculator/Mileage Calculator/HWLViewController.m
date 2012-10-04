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
@synthesize smileyImage;
@synthesize imageLabel;


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
    [self setImageLabel:nil];
    [self setSmileyImage:nil];
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
    float totalCost=[cost.text floatValue];
    
    float mileagePerGallon=0;
    float costPerMile=0;
    
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
    
    if (totalCost>0)
    {
        costPerMile=totalCost/totalMileage; 
    }
    else {
        UIAlertView *alertView= [[UIAlertView alloc]
                                 initWithTitle:@"Warning" message:@"The Cost Cannot be Zero" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    
    NSNumberFormatter *mileageFormatter=[[NSNumberFormatter alloc]init];
    [mileageFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    //update the label milesPerGallon
    //StringFromNumber: generates strings
    milesPerGallon.text=[mileageFormatter stringFromNumber:[NSNumber numberWithFloat:mileagePerGallon]];
    
    NSNumberFormatter *costFormatter=[[NSNumberFormatter alloc]init];
    [costFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    //update the label costPerGallon
    dollarsPerMile.text=[mileageFormatter stringFromNumber:[NSNumber numberWithFloat:costPerMile]];
}

-(void) updateImage{
    //I realize this is crude code, unfortunately, I was spending too much time trying to convert string (milesPerGallon) to float, and figured I'd just calculate it again.. 
    
    float totalFuel=[gallonsFilled.text floatValue];
    float oldMileage=[initialMileage.text floatValue];
    float newMileage=[currentMileage.text floatValue];
    float mileagePerGallon=0; 
    float totalMileage=newMileage-oldMileage;
    mileagePerGallon=totalMileage/totalFuel;
    
    if (mileagePerGallon<25) {
        imageLabel.text=@"We're sorry, your mileage is less than the national average";
        smileyImage.image=[UIImage imageNamed:@"sad-smiley.png"];
    } else if (mileagePerGallon>25) {
        imageLabel.text=@"Congratulations, your mileage is better than the national average!";
        smileyImage.image=[UIImage imageNamed:@"smile.png"];
    }
}

-(void)textFieldDidEndEditing: (UITextField *) textField
{
    [self updateMilesPerGallon];
    [self updateImage];
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
