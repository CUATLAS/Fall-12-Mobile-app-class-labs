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
@synthesize genre; 

// imageView downloaded from http://naldzgraphics.net/freebies/200-high-quality-free-paper-textures-to-grab/

- (void)viewDidLoad
{
    [super viewDidLoad];
        NSArray *array=[[NSArray alloc] initWithObjects:@"Country", @"Pop", @"Rock", @"Alternative", @"Hip Hop", @"Jazz", @"Classical", nil]; 
            self.genre=array;

}

- (void)viewDidUnload 
    
{
    [super viewDidUnload];
    [self setChoiceLabel:nil];
    [self setMusicPicker:nil];
    self.genre=nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
    {return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
        return [genre count];
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger) component{
        return [genre objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{ 
    choiceLabel.text=[NSString stringWithFormat:@"You like %@",
                      [genre objectAtIndex:row]];
    
}

@end
