//
//  MADViewController.m
//  musicPicker
//
//  Created by Jenna Raderstrong on 10/4/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize musicPicker;
@synthesize choiceLabel;
@synthesize genre;
@synthesize decade;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array=[[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical"  , nil];
    self.genre=array;
    NSArray *array2= [[ NSArray alloc] initWithObjects:@"1950's", @"1960's", @"1970's", @"1980's", @"1990's", @"2000's", @"2010's", nil];
    self.decade=array2;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    self.genre=nil;
    self.decade=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2; //number of components
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component==0){
        return [genre count];
    }
    else {return [decade count];}
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component==0)
    return [genre objectAtIndex:row];
    //returns content of row
    else return [decade objectAtIndex:row];
}
//called when row is selected
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger genrerow=[musicPicker selectedRowInComponent:0];
    NSInteger decaderow=[musicPicker selectedRowInComponent:1];
    //writes the string with the rows content ot the label
    choiceLabel.text=[NSString stringWithFormat:@"You like %@ from the %@.", [genre objectAtIndex:genrerow], [decade objectAtIndex:decaderow]] ;
}
@end












