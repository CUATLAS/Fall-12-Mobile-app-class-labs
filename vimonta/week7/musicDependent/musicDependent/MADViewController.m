//
//  MADViewController.m
//  musicDependent
//
//  Created by Aaron Vimont on 10/9/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize musicPicker;
@synthesize choiceLabel;
@synthesize artistAlbums, artists, albums;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // returns a bundle object of our app
	NSBundle *bundle = [NSBundle mainBundle];
    
    // retrieve the path of artistalbums.plist
    NSString *plistPath = [bundle pathForResource:@"artistalbums" ofType:@"plist"];
    
    // loads the contents of the plist file into a dictionary
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    // assigns the dictionary to artistAlbums
    self.artistAlbums = dictionary;
    
    // retrieve all the keys with the artist names
    NSArray *components = [self.artistAlbums allKeys];
    
    // populate the left component with the artist names
    self.artists = components;
    
    // get the artist at index 0
    NSString *selectedArtist = [self.artists objectAtIndex:0];
    
    // get the albums for the selected artist
    NSArray *array = [self.artistAlbums objectForKey:selectedArtist];
    
    // populate the right component with the album names
    self.albums = array;
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    [self setArtistAlbums:nil];
    [self setArtists:nil];
    [self setAlbums:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// Picker Delegate method
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// Required for the UIPickerViewDataSource protocol
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == artistComponent) {
        return [self.artists count];
    }
    else {
        return [self.albums count];
    }
}

// Picker Delegate methods
// returns the title for a given row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == artistComponent) {
        return [self.artists objectAtIndex:row];
    }
    else {
        return [self.albums objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == artistComponent) { // checks which component was picked
        // gets selected artist
        NSString *selectedArtist = [self.artists objectAtIndex:row];
        
        // gets the albums for the selected artist
        NSArray *array = [self.artistAlbums objectForKey:selectedArtist];
        
        // assigns the array of the albums to the right component
        self.albums = array;
        
        // set the right component back to 0
        [musicPicker selectRow:0 inComponent:albumComponent animated:YES];
        
        [musicPicker reloadComponent:albumComponent];
    }
    
    // gets the chosen row for the artists
    NSInteger artistrow = [musicPicker selectedRowInComponent:artistComponent];
    
    // gets the chosen row for the album
    NSInteger albumrow = [musicPicker selectedRowInComponent:albumComponent];
    
    // write the string with the selected rows content to the label
    choiceLabel.text = [NSString stringWithFormat:@"You like the album %@ by %@", [self.albums objectAtIndex:albumrow], [self.artists objectAtIndex:artistrow]];
}

@end
