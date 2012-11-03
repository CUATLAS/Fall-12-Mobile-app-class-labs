//
//  MADViewController.m
//  Music
//
//  Created by Aaron Vimont on 10/4/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
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
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *array = [[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical", nil];
    self.genre = array;
    
    NSArray *array2 = [[NSArray alloc] initWithObjects:@"1950s", @"1960s", @"1970s", @"1980s", @"1990s", @"2000s", @"2010s", nil];
    self.decade = array2;
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    self.genre = nil;
    self.decade = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Methods to implement pickers
// Required for the UIPickerViewDataSource protocol
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// Required for the UIPickerViewDataSource protocol
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [genre count];
    }
    else {
        return [decade count];
    }
}

// Picker Delegate methods
// returns the title for a given row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [genre objectAtIndex:row]; // returns the content of the row
    }
    else {
        return [decade objectAtIndex:row];
    }
}

// called when a row is selected
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // select row string from the genre and decade components
    NSInteger genreRow = [musicPicker selectedRowInComponent:0];
    NSInteger decadeRow = [musicPicker selectedRowInComponent:1];
    
    // write to the label
    choiceLabel.text = [NSString stringWithFormat:@"You like %@ from the %@", [genre objectAtIndex:genreRow], [decade objectAtIndex:decadeRow]];
}

@end
