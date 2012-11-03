//
//  MADViewController.m
//  beatles_rachelStrobel
//
//  Created by Rachel Strobel on 9/13/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
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
    imageControl.selectedSegmentIndex = -1;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBeatlesImage:nil];
    [self setTitleLabel:nil];
    [self setCapitalizedSwitch:nil];
    [self setFontSizeNumberLabel:nil];
    [self setImageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)updateImage{
    if(imageControl.selectedSegmentIndex==0){
        titleLabel.text=@"Young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    } else if (imageControl.selectedSegmentIndex==1){
        titleLabel.text=@"Not as young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
    }
}
-(void)updateCaps{
    if(capitalizedSwitch.on){
        titleLabel.text=[titleLabel.text uppercaseString];
    } else {
        titleLabel.text=[titleLabel.text lowercaseString];
    }
}

//Segment, which is similar to a button that changes the picture with what side fo the segment is touched

- (IBAction)changeImage:(UISegmentedControl *)sender {
    [self updateImage];
    [self updateCaps];
}

//Capitalization part of the application

- (IBAction)updateFont:(UISwitch *)sender {
    [self updateCaps];
}

//Font Code for changing our number lable and font with the slider

- (IBAction)changeFontSize:(UISlider *)sender {
    //get the font size
    int fontSize = sender.value;
    
    //change the font size label
    fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
    
    //create a new font object
    UIFont *newFont = [UIFont systemFontOfSize:sender.value];
    
    //apply the new font to the label
    titleLabel.font=newFont;
    
}
@end
