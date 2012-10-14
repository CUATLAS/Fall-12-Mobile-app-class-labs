//
//  MADViewController.m
//  Music
//
//  Created by  on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
    NSArray *array=[[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical", nil];
    self.genre=array;
    NSArray *array2=[[NSArray alloc] initWithObjects:@"1950s", @"1960s", @"1970s", @"1980s", @"1990s", @"2000s", @"2010s", nil];
    self.decade=array2;
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    [self setGenre:nil];
    [self setDecade:nil];
    [super viewDidUnload];
    //Array of data will be reacted everytime the view is loaded
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//Methods to implement the picker
//Required for the UIPickerViewDataSource protocol
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2; //Number of components
}

//Required for the UIPickerViewDataSource protocol
- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component{
    if (component==0) //Checks which component was picked and returns that component's row count
        return [genre count];
    else return [decade count];
    
}

//Picker Delegate methods
//Returns the title of a given row
- (NSString *)pickerView:(UIPickerView *)pickerView 
             titleForRow:(NSInteger)row 
            forComponent:(NSInteger)component{
    if (component==0) //Checks which component was picked and returns the value for the requested component
        return [genre objectAtIndex:row];
    else return [decade objectAtIndex:row];
    
}


//Called when a row is selected
- (void)pickerView:(UIPickerView *)pickerView
            didSelectRow:(NSInteger)row 
             inComponent:(NSInteger)component{
    NSInteger genrerow=[musicPicker selectedRowInComponent:0]; //Gets the chosen row for the genre
    NSInteger decaderow=[musicPicker selectedRowInComponent:1]; //Gets the chosen row for the decade
    //Writes the sring with the selecte row's content to the label
    choiceLabel.text=[NSString stringWithFormat:@"You like %@ from the %@", [genre objectAtIndex:genrerow], [decade objectAtIndex:decaderow]];
    
}

@end
