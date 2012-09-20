//
//  HWLViewController.m
//  beatles
//
//  Created by  on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize fontSizeNumberLabel;
@synthesize imageControl;
@synthesize beatlesImage;
@synthesize titleLabel;
@synthesize capitalizedSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBeatlesImage:nil];
    [self setTitleLabel:nil];
    [self setBeatlesImage:nil];
    [self setBeatlesImage:nil];
    [self setImageControl:nil];
    [self setCapitalizedSwitch:nil];
    [self setFontSizeNumberLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)changeImage:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex]==0) {
        titleLabel.text=@"Young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    } else if ([ sender selectedSegmentIndex]==1) {
        titleLabel.text=@"Not as young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
    }
}
- (IBAction)updateFont:(UISwitch *)sender {
    if (capitalizedSwitch.on) {
        titleLabel.text=[titleLabel.text uppercaseString];
    } else {
        titleLabel.text=[titleLabel.text lowercaseString];
    }
}

- (IBAction)changeFontSize:(UISlider *)sender {
    //get font size
    int fontSize = sender.value;
    
    //change the font size label;
    fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
    
    //create a new font object
    UIFont *newFont = [UIFont systemFontOfSize:fontSize];
    
    //apply the new font to the label
    titleLabel.font=newFont;
}
@end
