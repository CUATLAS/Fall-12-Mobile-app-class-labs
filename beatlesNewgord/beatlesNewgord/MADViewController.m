//
//  MADViewController.m
//  beatlesNewgord
//
//  Created by Alexia Newgord on 9/13/12.
//  Copyright (c) 2012 Alexia Newgord. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize fontSizeNumberLabel;
@synthesize imageControl;
@synthesize capitalizedSwitch;
@synthesize beatlesImage;
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
    [self setCapitalizedSwitch:nil];
    [self setFontSizeNumberLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)updateImage{
    if (imageControl.selectedSegmentIndex==0){
        titleLabel.text=@"Young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    }
       else if (imageControl.selectedSegmentIndex==1){
        titleLabel.text=@"Not as young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
    }
}
-(void)updateCaps{
    if(capitalizedSwitch.on){
        titleLabel.text = [titleLabel.text uppercaseString];
    }
    else{
        titleLabel.text = [titleLabel.text lowercaseString];
    }
}

- (IBAction)changeImage:(UISegmentedControl *)sender {
        [self updateImage];
        [self updateCaps];
}

- (IBAction)updateFont:(UISwitch *)sender {
    if(capitalizedSwitch.on){
        titleLabel.text=[titleLabel.text uppercaseString];
    }
    else{
        titleLabel.text=[titleLabel.text lowercaseString];
    }
}
- (IBAction)changeFontSize:(UISlider *)sender {
    int fontSize = sender.value;
    fontSizeNumberLabel.text = [NSString stringWithFormat:@"%d", fontSize];//makes the int a string and changest he font size label
    UIFont *newFont = [UIFont systemFontOfSize:sender.value];
    titleLabel.font = newFont;
    
}
@end
