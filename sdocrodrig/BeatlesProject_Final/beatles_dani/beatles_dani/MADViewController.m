//
//  MADViewController.m
//  beatles_dani
//
//  Created by new user on 9/17/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
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

- (IBAction)changeImage:(UISegmentedControl *)sender {
    if([sender selectedSegmentIndex]==0) {
        titleLabel.text=@"Young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    }else if ([sender selectedSegmentIndex]==1) {
        titleLabel.text=@"Not as young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
    }
}
- (IBAction)updateFont:(UISwitch *)sender {
    if (capitalizedSwitch.on){
        titleLabel.text=[titleLabel.text uppercaseString];
    } else {
        titleLabel.text=[titleLabel.text lowercaseString];
    } 
}
- (IBAction)changeFontSize:(UISlider *)sender {
    int fontSize = sender.value;
    fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
    UIFont *newFont = [UIFont systemFontOfSize:fontSize];
    titleLabel.font=newFont;
}
@end
