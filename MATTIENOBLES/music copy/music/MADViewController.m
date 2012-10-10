//
//  MADViewController.m
//  music
//
//  Created by Mattie Nobles on 10/4/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
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
    NSArray *array=[[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical", nil];
    self.genre=array;
    NSArray *array2=[[NSArray alloc] initWithObjects:@"1950s", @"1960s", @"1970s", @"1080s", @"1990s", @"2000s", @"2010s", nil];
    self.decade=array2;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    [super viewDidUnload];
    self.genre=nil;
    self.decade=nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0)
    return [genre count];
    else return [decade count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0)
    return [genre objectAtIndex:row];
    else return [decade objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger genrerow=[musicPicker selectedRowInComponent:0];
    NSInteger decaderow=[musicPicker selectedRowInComponent:1];
    choiceLabel.text=[NSString stringWithFormat:@"You Like %@ from the %@", [genre objectAtIndex:genrerow], [decade objectAtIndex:decaderow]];
}
@end
