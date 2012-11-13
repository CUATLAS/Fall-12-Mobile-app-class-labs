//
//  MADMexicoViewController.m
//  Project2
//
//  Created by Rachel Strobel on 11/8/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADMexicoViewController.h"

@interface MADMexicoViewController (){

NSDictionary *mexico;
NSArray *states;
    
}

@end

@implementation MADMexicoViewController
@synthesize statePicker, choiceLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"mexicodependent" ofType:@"plist"];
    NSArray *dictionary =[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.mexico=dictionary;    NSArray *components = [self.mexico allKeys];
    self.states=components;
    NSString *selectedState=[self.states objectAtIndex:0];
    NSArray *array=[self.mexico objectForKey:selectedState];
    self.values=array;
    NSLog(@"my states: %@", self.states);
}

- (void)viewDidUnload
{
    [self setChoiceLabel:nil];
    [self setStatePicker:nil];
    self.mexico=nil;
    self.states=nil;
    self.values=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation !=UIInterfaceOrientationPortraitUpsideDown);
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
        if (component==stateComponent)
            return [self.states count];
        else return [self.values count];
}

#pragma mark Picker Delegate Methods


 -(NSString *) pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger) component {
     if (component==stateComponent)
         return [self.states objectAtIndex:row];
     else return [self.values objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
             inComponent:(NSInteger)component{
    if (component==stateComponent){
        NSString *selectedState=[self.states objectAtIndex:row];
        NSArray *array=[self.mexico objectForKey:selectedState];
        self.values=array;
        //[statePicker selectRow:0 inComponent:valueComponent animated: YES];
        [statePicker reloadComponent:valueComponent];        
    }
    NSInteger staterow=[statePicker selectedRowInComponent:stateComponent];
    NSInteger valuerow=[statePicker selectedRowInComponent:valueComponent];
    choiceLabel.text=[NSString stringWithFormat:@"You chose the state of %@, which is %@", [self.values objectAtIndex:valuerow], [self.states objectAtIndex:staterow]];
   
}



@end
