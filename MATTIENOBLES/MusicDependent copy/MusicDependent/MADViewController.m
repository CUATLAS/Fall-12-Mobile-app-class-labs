//
//  MADViewController.m
//  MusicDependent
//
//  Created by Mattie Nobles on 10/9/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
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
    NSString *plistPath=[bundle pathForResource:@"artistalbums" ofType:@"plist"];
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
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
    [self setArtists:nil];
    self.artistAlbums=nil;
    self.albums=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==artistComponent)
        return [self.artists count];
    else return[self.albums count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==artistComponent)
        return [self.artists objectAtIndex:row];
    else return [self.albums objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView
didSelectRow: (NSInteger) row
       inComponent:(NSInteger)component{
    if (component==artistComponent){
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
