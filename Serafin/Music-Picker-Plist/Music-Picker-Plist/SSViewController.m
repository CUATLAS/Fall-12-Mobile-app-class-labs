//
//  SSViewController.m
//  Music-Picker-Plist
//
//  Created by Scott Serafin on 10/9/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController ()

@end

@implementation SSViewController

@synthesize musicPicker;
@synthesize artistLabel;
@synthesize albumLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"artistalbums" ofType: @"plist"];        // Path to plist file
    artistAlbumDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];     // Loads the contents of the plist into a dictionary
    
    // Populate artists array with all keys
    artists = [artistAlbumDictionary allKeys];
    // Populate albums array with first key's objects
    albums = [artistAlbumDictionary objectForKey:[artists objectAtIndex:0]];
    
    // Set the labels to the default selection so that the label is not empty
    artistLabel.text = [NSString stringWithFormat:@"%@", [artists objectAtIndex:0]];
    albumLabel.text = [NSString stringWithFormat:@"%@", [albums objectAtIndex:0]];
    
}

// Update the labels if a new selection is chosen
-(void)updateLabelWithArtist:(int)artistRow album:(int)albumRow
{
    artistLabel.text = [NSString stringWithFormat:@"%@", [artists objectAtIndex:artistRow]];
    albumLabel.text = [NSString stringWithFormat:@"%@", [albums objectAtIndex:albumRow]];
}


// Required for the picker to know how many sections we have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


// Counts
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case ARTISTCOMPONENT:
            return [artists count];
            break;
        case ALBUMCOMPONENT:
            return [albums count];
            break;
            
        default:
            return 0;
            break;
    }
}

// Titles
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case ARTISTCOMPONENT:
            return [artists objectAtIndex:row];
            break;
        case ALBUMCOMPONENT:
            return [albums objectAtIndex:row];
            break;
            
        default:
            return nil;
            break;
    }
}

// Selection changed
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == ARTISTCOMPONENT)
    {
        // Reset albums array
        albums = nil;
        albums = [artistAlbumDictionary objectForKey:[artists objectAtIndex:row]];
        
        // Reset album component to row 0
        [musicPicker selectRow:0 inComponent:ALBUMCOMPONENT animated:YES];
        [musicPicker reloadComponent:ALBUMCOMPONENT];
    }
    
    // Update labels
    int artistRow = [musicPicker selectedRowInComponent:ARTISTCOMPONENT];
    int albumRow = [musicPicker selectedRowInComponent:ALBUMCOMPONENT];
    [self updateLabelWithArtist:artistRow album:albumRow];
}



// Clean up memory
- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setArtistLabel:nil];
    [self setAlbumLabel:nil];
    artists = nil;
    albums = nil;
    artistAlbumDictionary = nil;
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
