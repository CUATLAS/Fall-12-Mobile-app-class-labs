//
//  SSViewController.m
//  Music-Picker
//
//  Created by Scott Serafin on 10/4/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController ()

@end

@implementation SSViewController
@synthesize musicPicker;
@synthesize musicChoice;
@synthesize genre;
@synthesize year;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *genres = [[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip-Hop", @"Jazz", @"Classical", nil];
    self.genre = genres;
    
    NSArray *years = [[NSArray alloc] initWithObjects:@"1950's", @"1960's", @"1970's", @"1980's", @"1990's", @"2000's", @"2010's", nil];
    self.year = years;
    
    genreString = @"Country";
    yearString = @"1950's";
}

// Custom String
- (void) updateLabelsWithGenre:(NSString *)genreVar year:(NSString *)yearVar
{
    musicChoice.text = [NSString stringWithFormat:@"You have selected %@ \nfrom the %@", genreVar, yearVar];
}





// Number of sections in the picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


// Choose what each picker section is so it knows which array to dispay
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [genre count];
    }
    else
    {
        return [year count];
    }
}


- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [genre objectAtIndex:row];
    }
    else
    {
        return [year objectAtIndex:row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        genreString = [genre objectAtIndex:row];
    }
    else
    {
        yearString = [year objectAtIndex:row];
    }
    
    [self updateLabelsWithGenre:genreString year:yearString];
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    [self setMusicChoice:nil];
    [self setMusicPicker:nil];
    self.genre = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
