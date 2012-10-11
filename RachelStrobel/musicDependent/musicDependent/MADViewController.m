//
//  MADViewController.m
//  musicDependent
//
//  Created by Rachel Strobel on 10/9/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize musicPicker;
@synthesize choiceLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle=[NSBundle mainBundle];
    //returns a bundle object of our app
    NSString *plistPath=[bundle pathForResource:@"artistalbums" ofType:@"plist"];
    //retrieve the path of artistablums.plist
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //loads the contest of the plist file into a dictionary
    //the dictionary uses the artists as the keys and a NSArray with the albums for earch artist.
    self.artistAlbums=dictionary;
    //assigns the dictionary to artistAlbums
    NSArray *components = [self.artistAlbums allKeys];
    //retrieve all the keys with the artist names
    self.artists=components;
    //populate the left component with the artist names
    NSString *selectedArtist=[self.artists objectAtIndex:0];
    //get the artist at index 0
    NSArray *array=[self.artistAlbums objectForKey:selectedArtist];
    //get the albums for the selected artist
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2; //number of components
}
    
//Required for the UIPickerViewDataSource protocol
    
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger) component{
    if (component==artistComponent)//checks which component was picked and returns that components row count
        return [self.artists count];
    else return [self.albums count];

}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow: (NSInteger)row
           forComponent: (NSInteger) component {
               if (component==artistComponent)
                   return [self.artists objectAtIndex:row];
               else return [self.albums objectAtIndex:row];
           }
      
-(void)pickerView:(UIPickerView *)pickerView
               didSelectRow: (NSInteger)row
                inComponent:(NSInteger)component{
                    if (component==artistComponent){
                        NSString *selectedArtist=[self.artists objectAtIndex:row];
                        NSArray *array=[self.artistAlbums objectForKey:selectedArtist];
                        self.albums=array;
                        [musicPicker selectRow:0 inComponent:albumComponent animated: YES];
                        [musicPicker reloadComponent:albumComponent];
                    }
    
                    NSInteger artistrow=[musicPicker selectedRowInComponent:artistComponent];
                    NSInteger albumrow=[musicPicker selectedRowInComponent:albumComponent];
                    choiceLabel.text=[NSString stringWithFormat:@"You like the album %@ by %@", [self.albums objectAtIndex:albumrow], [self.artists objectAtIndex:artistrow]];
                }

@end
