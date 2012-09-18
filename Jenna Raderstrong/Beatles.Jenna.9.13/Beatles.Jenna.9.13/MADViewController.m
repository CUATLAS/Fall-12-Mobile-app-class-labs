//
//  MADViewController.m
//  Beatles.Jenna.9.13
//
//  Created by Jenna Raderstrong on 9/13/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize fontSizeNumberLabel;
@synthesize imageControl;
@synthesize capitalizeSwitch;
@synthesize beatlesimage;
@synthesize titleLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBeatlesimage:nil];
    [self setTitleLabel:nil];
    [self setImageControl:nil];
    [self setCapitalizeSwitch:nil];
    [self setFontSizeNumberLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)updateImage{
    if(imageControl.selectedSegmentIndex==0) {
        titleLabel.text=@"Young Beatles";
        beatlesimage.image=[UIImage imageNamed:@"beatles1.png"];
    }else if (imageControl.selectedSegmentIndex==1){
        titleLabel.text=@"Old guys";
        beatlesimage.image=[UIImage imageNamed:@"beatles2.png"];
    }
    
}

-(void)updateCaps{
    if(capitalizeSwitch.on){
        titleLabel.text=[titleLabel.text uppercaseString];
    } else {
        titleLabel.text=[titleLabel.text lowercaseString];
    }
    }

- (IBAction)changeImage:(UISegmentedControl *)sender {
    [self updateImage];
    [self updateCaps];
    
    
   /* if([sender selectedSegmentIndex]==0) {
        titleLabel.text=@"Young Beatles";
        beatlesimage.image=[UIImage imageNamed:@"beatles1.png"];
    }else if ([sender selectedSegmentIndex]==1){
        titleLabel.text=@"Old guys";
        beatlesimage.image=[UIImage imageNamed:@"beatles2.png"]; */
    
    }
    

- (IBAction)updateFont:(UISwitch *)sender {
    [self updateCaps];
}
- (IBAction)changeFontSize:(UISlider *)sender {
    //get font size
    int fontSize = sender.value;
    //change font size label
    fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
    //create a new font object
    UIFont *newFont= [UIFont systemFontOfSize:sender.value];
    
    //apply the new font to the label
    titleLabel.font=newFont;
}
@end






