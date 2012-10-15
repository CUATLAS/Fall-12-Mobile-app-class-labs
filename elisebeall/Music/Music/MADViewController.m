//
//  MADViewController.m
//  Music
//
//  Created by Elise J Beall on 10/4/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array=[[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Electronic", @"Jazz", @"Rock", @"Hip Hop", @"Classical", @"Blues", @"r/futurebeats", nil];
    self.genre=array;
    
    NSArray *array2=[[NSArray alloc] initWithObjects:@"1920s", @"1930s", @"1940s", @"1950s", @"1960s", @"1970s", @"1980s", @"1990s", @"2000s", @"2010s", nil];
    self.decade=array2;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.genre=nil;
    self.decade=nil;
    // Dispose of any resources that can be recreated.
}

//Methods to implement the picker
//Required for the UIPickerViewDataSource protocol
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)
    pickerView{
    return 2; //number of components
}

//Required for the UIPickerViewDataSource protocol
- (NSInteger) pickerView:(UIPickerView *)pickerView
 numberOfRowsInComponent:(NSInteger)component{
    if (component==0) //checks which component was picked and returns the value for the requested component.
        return [_genre count];
    else return [_decade count];
}

//Picker Delegate methods
//returns the title for a given row
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    if (component==0) //checks which component was picked and returns the value for the requested component.
        return [_genre objectAtIndex:row];  //returns the content of the row
    else return [_decade objectAtIndex:row];
}

//called when a row is selected
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    NSInteger genrerow=[_musicPicker selectedRowInComponent:0]; //gets the choosen row for the genre
    NSInteger decaderow=[_musicPicker selectedRowInComponent:1]; //gets the choosen row for the decade
    //writes the string with the row's content to the label
    _choiceLabel.text=[NSString stringWithFormat:@"You like %@ from the %@", [_genre objectAtIndex:genrerow], [_decade objectAtIndex:decaderow]];
    
    if (genrerow == 8 && decaderow == 9) {
        _youreCool.text=[NSString stringWithFormat:@"You're cool."];
    }
}

@end
