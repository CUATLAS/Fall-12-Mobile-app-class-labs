//
//  HWLViewController.m
//  MusicDependent
//
//  Created by  on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
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
    //returns a bundle object for the app - a bundle is an object that represents a location in memory where the code and resources are grouped so that can be used in a program
    
    NSString *plistPath=[bundle pathForResource:@"artistalbums" ofType:@"plist"]; //path for plist being stored in a string file
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath]; //initwithContentsofFile initializes a newly created dictionary with the contents of a file path 
    self.artistAlbums=dictionary; //assigns the dictionary to artistAlbums - a dictionary outlined in the h file
    NSArray *components = [self.artistAlbums allKeys]; //the dictionary uses the artists as te keys and a NSArray with the albums for each artist. this command retreives all the keys with the artist names
    
    self.artists=components; //populate the left component with the artist names
    
    //pickers start with the first row selected by default 
    NSString *selectedArtist=[self.artists objectAtIndex:0]; //get the artist at index 0
    
    NSArray *array=[self.artistAlbums objectForKey:selectedArtist]; //get the album for the selected artists 
    self.albums=array;
    //populate the right component with the album names
    
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    self.artistAlbums=nil;
    self.artists=nil;
    self.albums=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
return 2;
} // required for the UIPickerViewDataSource protocol

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==artistComponent) //checks which component was picked and returns that component row
return [self.artists count];
else return [self.albums count];
}

//Picker Delegate methods
//returns the title for a given row
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { 
if (component==artistComponent) //checks which component was picked and returns the value for the requested component
return [self.artists objectAtIndex:row];
else return [self.albums objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
if (component==artistComponent) { //checks which component was picked 

    NSString *selectedArtist=[self.artists objectAtIndex:row];

    NSArray *array=[self.artistAlbums objectForKey:selectedArtist];
    
    self.albums=array;
    
    [musicPicker selectRow:0 inComponent:albumComponent animated:YES];
    [musicPicker reloadComponent:albumComponent];

    
}

NSInteger artistrow=[musicPicker selectedRowInComponent:artistComponent];
NSInteger albumrow=[musicPicker selectedRowInComponent:albumComponent];
choiceLabel.text=[NSString stringWithFormat:@"You like the album %@ by %@", [self.albums objectAtIndex:albumrow], [self.artists objectAtIndex:artistrow]];

                  }
                  
@end
