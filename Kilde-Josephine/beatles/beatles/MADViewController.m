//
//  MADViewController.m
//  beatles
//
//  Created by  on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize imageControl;
@synthesize fontSizeNumberLabel;
@synthesize capitalizeSwitch;
@synthesize beatlesImage;
@synthesize titleLabel;

- (void)viewDidLoad
{
    imageControl.selectedSegmentIndex = -1;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBeatlesImage:nil];
    [self setTitleLabel:nil];
    [self setCapitalizeSwitch:nil];
    [self setFontSizeNumberLabel:nil];
    [self setImageControl:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) updateImage { 
    if (imageControl.selectedSegmentIndex== 0){
    titleLabel.text=@"Young Beatles";
    beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    } else if (imageControl.selectedSegmentIndex==1) {
    titleLabel.text=@"Not as young Beatles";
    beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
    }
}
    
-(void)updateCaps{
    if (capitalizeSwitch.on) {
        titleLabel.text=[titleLabel.text uppercaseString];
    } else {
        titleLabel.text=[titleLabel.text lowercaseString];
    }
}

- (IBAction)changeImage:(UISegmentedControl *)sender {
    [self updateImage];
    [self updateCaps];
    
}


- (IBAction) updateFont:(UISwitch *) sender {
        [self updateCaps];
    
}

- (IBAction)changeFontSize:(UISlider *)sender {
    //Get the font size
    int fontSize = sender.value;
    
    //Change the font size label
    //Converts int (size) to string (label)
    fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
    
    //Create a new font object (to change font attributes)
    UIFont *newFont = [UIFont systemFontOfSize:fontSize];
    
    //Apply the new font to the label
    titleLabel.font=newFont;
}
@end
