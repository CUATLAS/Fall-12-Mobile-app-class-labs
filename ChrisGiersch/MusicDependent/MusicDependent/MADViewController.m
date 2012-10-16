//
//  MADViewController.m
//  MusicDependent
//
//  Created by Chris Giersch on 10/9/12.
//  Copyright (c) 2012 Chris Giersch. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize musicPicker;
@synthesize choiceLabel;
@synthesize artistAlbums;
@synthesize artists;
@synthesize albums;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle=[NSBundle mainBundle];
    // Returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"artistalbums" ofType:@"plist"];
    // Retrieve the path of artistalbums.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    // Loads the contents of the plist file into a dictionary
    // The dictionary uses the artists as the keys and a NSArray with the albums for each artist
    self.artistAlbums=dictionary;
    // Assigns the dictionary to artistAlbums
    NSArray *components = [self.artistAlbums allKeys];
    // Retrieve the left component with the artist names
    self.artists = components;
    // Populate the left component with the artist names
    NSString *selectedArtist = [self.artists objectAtIndex:0];
    // Get the artist at index 0
    NSArray *array = [self.artistAlbums objectForKey:selectedArtist]; // Get the albums for the selected artist
    self.albums = array;
    //populate the right component with the album names
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    [self setArtistAlbums:nil];
    self.artists=nil;
    self.albums=nil;
}

- (void)applicationWillEnterForeground
{
    [super didReceiveMemoryWarning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Picker Delegate method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2; // Number of components
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==artistComponent) // Checks which component was picked and returns that components row count
        return [self.artists count];
    else return [self.albums count];
}

// Picker Delegate methods
// Returns the title for a given row
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (component==artistComponent) // Checks which component was picked and returns the value for the requested component.
        return [self.artists objectAtIndex:row];
    else return [self.albums objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (component==artistComponent) // Checks which component was picked
    {
        NSString *selectedArtist = [self.artists objectAtIndex:row]; // Gets the selected artist
        NSArray *array = [self.artistAlbums objectForKey:selectedArtist]; // Gets the albums for the selected artist
        self.albums=array; // Assigns the array of albums to the right component
        [musicPicker selectRow:0 inComponent:albumComponent animated:YES]; // Set the right compnent back to 0
        [musicPicker reloadComponent:albumComponent]; // reload the right component
    }
    NSInteger artistrow=[musicPicker selectedRowInComponent:artistComponent]; // Gets the choosen row for the artist
    NSInteger albumrow=[musicPicker selectedRowInComponent:albumComponent]; // Gets the choosen row for the album
    choiceLabel.text=[NSString stringWithFormat:@"You like the album %@ by %@.", [self.albums objectAtIndex:albumrow], [self.artists objectAtIndex:artistrow]]; // Writes the string with the selected row's content to the label
}

@end
