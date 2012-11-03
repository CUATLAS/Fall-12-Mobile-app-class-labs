//
//  MADViewController.m
//  MetricCalculator
//
//  Created by Rachel Strobel on 10/4/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "MADViewController.h"



@interface MADViewController ()

@end

@implementation MADViewController
@synthesize textEnterNumber;
@synthesize labelAnswer;
@synthesize labelFormula;



- (void)viewDidLoad
{
    [super viewDidLoad];
    textEnterNumber.delegate=self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    
    [self setLabelAnswer:nil];
    [self setLabelFormula:nil];
    [self setTextEnterNumber:nil];
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

-(void)updateFormulaTotals:(NSString *)textToBeConverted forFunctionType:(int)fType
{
    if(fType == 1) {
        float temp = [textEnterNumber.text floatValue];
        float ans = temp * 1.60934;
        labelAnswer.text = [[NSNumber numberWithFloat:ans] stringValue];
    } else if(fType == 2) {
        float temp = [textEnterNumber.text floatValue];
        float ans = temp * 0.453592;
        labelAnswer.text = [[NSNumber numberWithFloat:ans] stringValue];
    } else if(fType == 3) {
        float temp = [textEnterNumber.text floatValue];
        float ans = temp * 0.621371;
        labelAnswer.text = [[NSNumber numberWithFloat:ans] stringValue];
    } else if(fType == 4) {
        float temp = [textEnterNumber.text floatValue];
        float ans = temp * 2.20462;
        labelAnswer.text = [[NSNumber numberWithFloat:ans] stringValue];
    }
    
    if([textEnterNumber.text floatValue] == 0)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Enter a number greater than 0" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        
        [alertView show];
    }

}


- (IBAction)segFormula:(UISegmentedControl *)sender {
    if([sender selectedSegmentIndex]==0)
    {
        labelFormula.hidden=NO;
    }
    else
    {
        labelFormula.hidden=YES;
    }
}

- (IBAction)milesToKilometers:(UIButton *)sender {
    
    // call UpdateFormulaTotals passing in nmber entered as a parameter
    [self updateFormulaTotals:textEnterNumber.text forFunctionType:1];
    
}

- (IBAction)kilometersToMiles:(UIButton *)sender {
    labelFormula.text=@"kilometers * 0.453592";
    [self updateFormulaTotals:textEnterNumber.text forFunctionType:2];
}

- (IBAction)poundsToKilograms:(UIButton *)sender {
    labelFormula.text=@"pounds * 0.621371";
    [self updateFormulaTotals:textEnterNumber.text forFunctionType:3];
}

- (IBAction)kilogramsToPounds:(UIButton *)sender {
    labelFormula.text=@"kilograms * 2.20462";
    [self updateFormulaTotals:textEnterNumber.text forFunctionType:4];
}
@end
