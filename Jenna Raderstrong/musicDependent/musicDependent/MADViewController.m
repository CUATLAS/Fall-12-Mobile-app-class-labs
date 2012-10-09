//
//  MADViewController.m
//  musicDependent
//
//  Created by Jenna Raderstrong on 10/9/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
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
    //returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"artistalbums" ofType:@"plist"];
    //retrieve the path of artistalbums.plist
    NSDictionary *dictionary= [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //load contents of the plist in the file dictionary
    //the dictionary uses the artists as the keys and teh NSArray with the albums for each artist
    self.artistAlbums=dictionary;
    NSArray *components = [self.artistAlbums allKeys];
    self.artists=components;
    
    NSString *selectedArtist=[self.artists objectAtIndex:0];
    NSArray *array=[self.artistAlbums objectForKey:selectedArtist];
    self.albums=array;
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setChoiceLabel:nil];
    [self setArtistAlbums:nil];//can do this
    [super viewDidUnload];
    self.artists=nil;//or this
    self.albums=nil;
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==artistComponent) //checks which component was picked
        return [self.artists count];
    else return [self.albums count];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component==artistComponent)
        return [self.artists objectAtIndex:row];
    else return [self.albums objectAtIndex: row];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
if(component==artistComponent){
    NSString *selectedArtist=[self.artists objectAtIndex:row];
    NSArray *array= [self.artistAlbums objectForKey:selectedArtist];//get the albums for the selected artist
    self.albums=array;
    [musicPicker selectRow:0 inComponent:albumComponent animated:YES]; //set the right component back to 0
    [musicPicker reloadComponent:albumComponent];
}
    
    NSInteger artistrow=[musicPicker selectedRowInComponent:artistComponent];
    NSInteger albumrow=[musicPicker selectedRowInComponent:albumComponent];
    choiceLabel.text=[NSString stringWithFormat: @"You Like %@ by %@", [self.albums objectAtIndex:albumrow], [self.artists objectAtIndex:artistrow]];
}

@end










