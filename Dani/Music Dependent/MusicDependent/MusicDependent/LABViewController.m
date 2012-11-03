//
//  LABViewController.m
//  MusicDependent
//
//  Created by new user on 10/11/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import "LABViewController.h"

@interface LABViewController ()

@end

@implementation LABViewController
@synthesize choiceLabel;
@synthesize musicPicker;

- (void)viewDidLoad
{
    NSBundle *bundle=[NSBundle mainBundle];
    //returns a bundle object of our app
	NSString *plistPath=[bundle pathForResource:@"artistAlbums" ofType:@"plist"];
    //retrieve the path of artistalbums.plist
	NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //loads the contents of the plist file into a dictionary
    //the dictionary uses the artists as the keys and a NSArray with the albums for each artist.
	self.artistAlbums=dictionary;
    //assigns the dictionary to artistAlbums
	NSArray *components = [self.artistAlbums allKeys];
    //retrieve all the keys with the artist names
	self.artists=components;
    // populate the left component with the artist names
	NSString *selectedArtist=[self.artists objectAtIndex:0];
    //get the artist at index 0
	NSArray *array=[self.artistAlbums objectForKey:selectedArtist]; //get the albums for the selected artist
	self.albums=array;
    //populate the right component with the album names
}
- (void)viewDidUnload
{
    [self setChoiceLabel:nil];
    [self setMusicPicker:nil];
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2; //number of components
}

//Required for the UIPickerViewDataSource protocol
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
	if (component==artistComponent) //checks which component was picked and returns that components row count
		return [self.artists count];
	else return[self.albums count];
}

//Picker Delegate methods
//returns the title for a given row
-(NSString *)pickerView:(UIPickerView *)pickerView
titleForRow:(NSInteger) row
           forComponent:(NSInteger) component {
    if (component==artistComponent) //checks which component was picked and returns the value for the requested component
        return [self.artists objectAtIndex:row];
    else return [self.albums objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView
didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    if(component==artistComponent){
        // checks which component was picked
        NSString *selectedArtist=[self.artists objectAtIndex:row]; // gets selected artist
        NSArray *array=[self.artistAlbums objectForKey:selectedArtist]; // gets the albums for the selected artist
        self.albums=array;
        // assigns the array of albums to the right component
        [musicPicker selectRow:0 inComponent:albumComponent animated:YES]; // set the right component back to 0
        [musicPicker reloadComponent:albumComponent];
        //reload the right component
    
    }
    NSInteger artistrow=[musicPicker selectedRowInComponent:artistComponent];
    // gets the choosen row for the artist
    NSInteger albumrow=[musicPicker selectedRowInComponent:albumComponent];
    // gets the chosen row for the album
    // writes the string with the selected row's content to the label
    choiceLabel.text=[NSString stringWithFormat:@"You like the album %@ by %@", [self.albums objectAtIndex:albumrow], [self.artists objectAtIndex:artistrow]];
}

@end
