//
//  MADViewController.m
//  music
//
//  Created by Chris Giersch on 10/4/12.
//  Copyright (c) 2012 Chris Giersch. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize trickPicker;
@synthesize choiceLabel;
@synthesize trick;
@synthesize penalty;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array=[[NSArray alloc] initWithObjects:@"Spread Eagle", @"Daffy", @"Mule Kick", @"Crotch Grab", @"Twister", @"Kosak", @"Any Grab", @"Three Sixty", @"Switch 3", @"Five Forty", @"Switch 5", @"Seven Twenty", @"Switch 7", @"Nine Hundred", @"Switch 9", @"Ten Eighty", @"Switch 10", @"Twelve Sixty", @"Switch 12", @"Forteen Forty", @"Switch 14", @"Front Flip", @"Double Front", @"Back Flip", @"Double Back", @"Switch Back", @"Switch Back 180", @"Lincoln Loop", @"Misty 5", @"Misty 7", @"Rodeo 5", @"Rodeo 7", nil];
    self.trick=array;
    NSArray *array2=[[NSArray alloc] initWithObjects:@"a Binding Butt", @"a Belly Flop", @"you Cheated", nil];
    self.penalty=array2;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTrickPicker:nil];
    [self setChoiceLabel:nil];
    self.trick=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Methods to implement the picker
// Required for the UIPickerViewDataSource protocol
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2; // Number of components
}

// Required for the UIPickerViewDataSource protocol
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return [trick count];
    }
    else
    {
        return [penalty count];
    }
}

// Picker Delegate methods
// Returns the title for a given row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [trick objectAtIndex:row]; // Returns the content of the row
    }
    else{
        return [penalty objectAtIndex:row];
    }
}

// Called when a row is selected
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger trickRow=[trickPicker selectedRowInComponent:0];
    NSInteger penaltyRow=[trickPicker selectedRowInComponent:1];
    // Writes the string with the row's content to the label
    choiceLabel.text=[NSString stringWithFormat:@"Gnarly! You did a %@...but then %@!?", [trick objectAtIndex:trickRow], [penalty objectAtIndex:penaltyRow]];
}

@end
