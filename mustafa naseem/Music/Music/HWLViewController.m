//
//  HWLViewController.m
//  Music
//
//  Created by  on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize musicPicker;
@synthesize choiceLabel;

@synthesize genre;
@synthesize decade;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *array = [[NSArray alloc] initWithObjects:@"country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical" , nil];
    NSArray *array2 = [[NSArray alloc] initWithObjects: @"1950s", @"1960s", @"1970s", @"1980s", @"1990s", @"2000s", @"2010s", nil];
    self.genre=array;
    self.decade=array2;
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    self.genre=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0)
        return [genre count];
    else return [decade count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (component==0)
        return [genre objectAtIndex:row];
    else return [decade objectAtIndex:row];
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger genrerow= [musicPicker selectedRowInComponent:0];
    NSInteger decaderow= [musicPicker selectedRowInComponent:1];
    choiceLabel.text= [NSString stringWithFormat:@"You like %@ from the %@", [genre objectAtIndex:genrerow], [decade objectAtIndex:decaderow]];
}
@end
