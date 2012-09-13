//
//  MADViewController.m
//  beatles
//
//  Created by Aaron Vimont on 9/13/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize beatlesImage;
@synthesize titleLabel;
@synthesize imageControl;
@synthesize capitalizedSwitch;
@synthesize fontSizeNumberLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBeatlesImage:nil];
    [self setTitleLabel:nil];
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

- (void)updateImage {
    if (imageControl.selectedSegmentIndex == 0) {
        titleLabel.text = @"Young Beatles";
        beatlesImage.image = [UIImage imageNamed:@"beatles1.png"];
    } else if (imageControl.selectedSegmentIndex == 1) {
        titleLabel.text = @"Not as young Beatles";
        beatlesImage.image = [UIImage imageNamed:@"beatles2.png"];
    }
}

- (void)updateCaps {
    if (capitalizedSwitch.on) {
        titleLabel.text = [titleLabel.text uppercaseString];
    } else {
        titleLabel.text = [titleLabel.text lowercaseString];
    }
}

- (IBAction)changeImage:(UISegmentedControl *)sender {
    [self updateImage];
    [self updateCaps];
}

- (IBAction)updateFont:(UISwitch *)sender {
    [self updateCaps];
}

- (IBAction)changeFontSize:(UISlider *)sender {
    // get the font size
    int fontSize = sender.value;
    
    // change the font size label
    fontSizeNumberLabel.text = [NSString stringWithFormat:@"%d", fontSize];
    
    // create a new font object
    UIFont *newFont = [UIFont systemFontOfSize:fontSize];
    
    // apply the new font to the label
    titleLabel.font = newFont;
}
@end
