//
//  metricCalcViewController.m
//  Sayansi
//
//  Created by  on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "metricCalcViewController.h"

@interface metricCalcViewController ()

@end

@implementation metricCalcViewController

@synthesize enterNumberTextField;
@synthesize answerLabel;
@synthesize formulaLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	enterNumberTextField.delegate = self;
}

- (void)viewDidUnload
{
    [self setEnterNumberTextField:nil];
    [self setAnswerLabel:nil];
    [self setFormulaLabel:nil];
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
-(void)updateFormulaTotals:(NSString *)textToBeConverted forFunctionType:(int)fType {
    if (fType == 1) {
        float temp = [enterNumberTextField.text floatValue];
        float ans = temp * 1.60934;
        answerLabel.text = [[NSNumber numberWithFloat:ans] stringValue];
    }
    else if(fType == 2) {
        float temp = [enterNumberTextField.text floatValue];
        float ans = temp * 0.453592;
        answerLabel.text = [[NSNumber numberWithFloat:ans] stringValue];
    } 
    else if(fType == 3) {
        float temp = [enterNumberTextField.text floatValue];
        float ans = temp * 0.621371;
        answerLabel.text = [[NSNumber numberWithFloat:ans] stringValue];
    } 
    else if(fType == 4) {
        float temp = [enterNumberTextField.text floatValue];
        float ans = temp * 2.20462;
        answerLabel.text = [[NSNumber numberWithFloat:ans] stringValue];
    }
   
    
    if([enterNumberTextField.text floatValue] == 0)
    {
        UIAlertView *alertView=[[UIAlertView alloc] 
                                initWithTitle:@"Warning!" 
                                message:@"Enter a number greater than 0" 
                                delegate:self 
                                cancelButtonTitle:@"Cancel" 
                                otherButtonTitles: nil];
        
        [alertView show];
    }
}

- (IBAction)segControlFormula:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex]==0) {
        formulaLabel.hidden = NO;
    }
    else {
        formulaLabel.hidden = YES;
    }
}

- (IBAction)miToKmButton:(UIButton *)sender {
    
    // call UpdateFormulaTotals passing in nmber entered as a parameter
    formulaLabel.text=@"miles * 1.60934";    
    [self updateFormulaTotals:enterNumberTextField.text forFunctionType:1];}

- (IBAction)kmToMiButton:(UIButton *)sender {
    
    formulaLabel.text=@"kilometers * 0.453592";
    [self updateFormulaTotals:enterNumberTextField.text forFunctionType:2];
}

- (IBAction)lbToKgButton:(UIButton *)sender {
    
    formulaLabel.text=@"pounds * 0.621371";
    [self updateFormulaTotals:enterNumberTextField.text forFunctionType:3];
}

- (IBAction)kgToLbButton:(UIButton *)sender {
    
    formulaLabel.text=@"kilograms * 2.20462";
    [self updateFormulaTotals:enterNumberTextField.text forFunctionType:4];}
@end
