//
//  LABViewController.m
//  MusicPicker
//
//  Created by new user on 10/10/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import "LABViewController.h"

@interface LABViewController ()

@end

@implementation LABViewController
@synthesize choiceLabel;
@synthesize musicPicker;
@synthesize genre; // @property in .h file must have an @synthesize in .m file
@synthesize decade;

//imageView dowloaded from http://www.dinpattern.com/

- (void)viewDidLoad
{
    [super viewDidLoad];
        NSArray *array=[[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical", nil]; // array must always end with nil so it knows it's the end
            self.genre=array;
        NSArray *array2=[[NSArray alloc] initWithObjects:@"1950s", @"1960s", @"1970s", @"1980s", @"1990s", @"2000s", @"2010s", nil];
            self.decade=array2;

}

- (void)viewDidUnload // called when the controller's view is released from memory. It's the counterpart to viewDidLoad, so anything set there can be flushed in viewDidUnload because it is set again when the view is reloaded.
    
{
    [super viewDidUnload];
    [self setChoiceLabel:nil];
    [self setMusicPicker:nil];
    self.genre=nil; //array of data will be recreated every time the view is loaded. In most cases, only outlet would be set to nil, but here array is to because it is recreated in viewDidLoad
    self.decade=nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) 
        return [genre count];
    else return[self.decade count];
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger) component{
    if (component==0)
        return [self.genre objectAtIndex:row]; else return [self.decade objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger genrerow=[musicPicker selectedRowInComponent:0];
    NSInteger decaderow=[musicPicker selectedRowInComponent:1]; 
    choiceLabel.text=[NSString stringWithFormat:@"You like %@ from the %@", [genre objectAtIndex:genrerow], [decade objectAtIndex:decaderow]];
}

@end
