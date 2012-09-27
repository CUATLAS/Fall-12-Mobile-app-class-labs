//
//  MADViewController.m
//  Beatles
//
//  Created by Elise J Beall on 9/25/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize beatlesImage;
@synthesize fontSizeNumberLabel;
@synthesize capitalizeSwitch;
@synthesize imageControl;
@synthesize titleLabel;

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
    [self setCapitalizeSwitch:nil];
    [self setFontSizeNumberLabel:nil];
    [self setBeatlesImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)updateImage{
    if (imageControl.selectedSegmentIndex==0) {
        titleLabel.text=@"Young Beatles";
		beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    } else if (imageControl.selectedSegmentIndex==1) {
        titleLabel.text=@"Old(er) Beatles";
		beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
    }
}

-(void)updateCaps{
    if (capitalizeSwitch.on){
        titleLabel.text=[titleLabel.text uppercaseString];
    } else {
        titleLabel.text=[titleLabel.text lowercaseString];
    }
}

- (IBAction)changeFontSize:(UISlider *)sender {
    //get the font size
	int fontSize = sender.value;
	
	// change the font size label
	fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
	
	// create a new font object
	//UIFont *newFont = [UIFont systemFontOfSize:sender.value];
    
    UIFont *newFont = [UIFont fontWithName:@"Papyrus" size:sender.value];
	
	//apply the new font to the label
	titleLabel.font=newFont;
}

- (IBAction)updateFont:(UISwitch *)sender {
    [self updateCaps];
}

- (IBAction)changeImage:(UISegmentedControl *)sender {
    [self updateImage];
    [self updateCaps];
}
@end
