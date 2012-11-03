//
//  ViewController.m
//  MusicDependent
//
//  Created by Stephen Feuerstein on 10/9/12.
//  Copyright (c) 2012 GingerSnAPPs. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize musicPicker;
@synthesize selectionLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    musicPicker.delegate = self;
    musicPicker.dataSource = self;
    
    // Load .plist into NSArrays for artists and albums
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"artistalbums" ofType:@"plist"];
    artistAlbumsDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    // Populate artists array with all keys
    artists = [artistAlbumsDict allKeys];
    // Populate albums array with first key's objects
    albums = [artistAlbumsDict objectForKey:[artists objectAtIndex:0]];
    
    selectionLabel.text = [NSString stringWithFormat:@"You chose:\n %@\n%@", [artists objectAtIndex:0], [albums objectAtIndex:0]];
}

-(void)updateLabelWithArtist:(int)artistRow album:(int)albumRow
{
    selectionLabel.text = [NSString stringWithFormat:@"You chose:\n %@\n%@",
                           [artists objectAtIndex:artistRow], [albums objectAtIndex:albumRow]];
}

- (void)viewDidUnload
{
    [self setMusicPicker:nil];
    [self setSelectionLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    artists = nil;
    albums = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
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
        albums = [artistAlbumsDict objectForKey:[artists objectAtIndex:row]];
        
        // Reset album component to row 0
        [musicPicker selectRow:0 inComponent:ALBUMCOMPONENT animated:YES];
        [musicPicker reloadComponent:ALBUMCOMPONENT];
    }
    
    // Update labels
    int artistRow = [musicPicker selectedRowInComponent:ARTISTCOMPONENT];
    int albumRow = [musicPicker selectedRowInComponent:ALBUMCOMPONENT];
    [self updateLabelWithArtist:artistRow album:albumRow];
}

@end
