//
//  MADViewController.m
//  MusicDependent
//
//  Created by Elise J Beall on 10/9/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
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
	// Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle=[NSBundle mainBundle];
    //returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"artistalbums" ofType:@"plist"];
    //retrieve the parth of artistalbums.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //loads the contents of the plist file into a dictionary
    //the dictionary uses the artists as the keys and an NSArray with the albums for each artist
    self.artistAlbums=dictionary;
    //asigns the dictionary to artistAlbums
    NSArray *components=[self.artistAlbums allKeys];
    //retrieve all the keys with the artist names
    self.artists=components;
    //populate the left component with the artist names
    NSString *selectedArtist=[self.artists objectAtIndex:0];
    //gets the artist at index 0
    NSArray *array=[self.artistAlbums objectForKey:selectedArtist];
    //get the albums for the selected array
    self.albums=array;
    //populate the right component with the album names
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    [self setArtistAlbums:nil];
    [self setArtists:nil];
    [self setAlbums:nil];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2; //number of components
}

//required for the UIPickerViewDateSource
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component==artistComponent)
        //checks which component was picked and returns that components row count
        return [self.artists count];
    else return [self.albums count];
}

//Picker Delegate methods
//returns the title for a given row
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    if (component==artistComponent)
        //checks which component was picked and returns the value for the requested component
        return [self.artists objectAtIndex:row];
    else return [self.albums objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    if (component==artistComponent){
        //checks which component was picked
        NSString *selectedArtist=[self.artists objectAtIndex:row];
        //gets the selected artist
        NSArray *array=[self.artistAlbums objectForKey:selectedArtist];
        //gets the albums for the selected artist
        self.albums=array;
        //assigns the array of albums to the right component
        [musicPicker selectRow:0 inComponent:albumComponent animated:YES];
        //set the right component back to 0
        [musicPicker reloadComponent:albumComponent];
        //reload the right component
    }
    
    NSInteger artistrow=[musicPicker selectedRowInComponent:artistComponent];
    //gets the choosen row for the artist
    NSInteger albumrow=[musicPicker selectedRowInComponent:albumComponent];
    //gets the choosen row for the album
    //writes the string with the selected row's content to the label
    
    choiceLabel.text=[NSString stringWithFormat:@"You like the album %@ by %@", [self.albums objectAtIndex:albumrow], [self.artists objectAtIndex:artistrow]];
}

@end
