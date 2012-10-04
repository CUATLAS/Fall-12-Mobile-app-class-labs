//
//  ViewController.m
//  MusicPicker
//
//  Created by Stephen Feuerstein on 10/4/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize musicPicker;
@synthesize outputLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    yearString = nil;
    genreString = nil;
    
    musicPicker.delegate = self;
    musicPicker.dataSource = self;
    
    outputLabel.text = @"Pick a genre and year";
    
    genres = [[NSArray alloc] initWithObjects:
              @"Alternative",
              @"Blues",
              @"Country",
              @"DubStep",
              @"Hip Hop",
              @"Jazz",
              @"R&B", nil];
    years = [[NSArray alloc] initWithObjects:
             @"1950",
             @"1960",
             @"1970",
             @"1980",
             @"1990",
             @"2000",
             @"2010", nil];
}

// Helper method to update label string
-(void)updateLabelWithGenre:(NSString *)genre year:(NSString *)year
{
    year = [years objectAtIndex:[musicPicker selectedRowInComponent:1]];
    genre = [genres objectAtIndex:[musicPicker selectedRowInComponent:0]];
    
    if (year == nil || genre == nil)
        return;
    
    outputLabel.text = [NSString stringWithFormat:@"%@s %@", year, genre];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return genres.count;
    else
        return years.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
        return [genres objectAtIndex:row];
    else
        return [years objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        genreString = [genres objectAtIndex:row];
    }
    else
    {
        yearString = [years objectAtIndex:row];
    }
    
    //NSLog(@"%@, %@", yearString, genreString);
    
    [self updateLabelWithGenre:genreString year:yearString];
}

- (void)viewDidUnload {
    [self setMusicPicker:nil];
    [self setOutputLabel:nil];
    [super viewDidUnload];
}
@end
