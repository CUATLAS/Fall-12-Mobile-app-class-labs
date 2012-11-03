//
//  MADViewController.m
//  beatlesjt
//
//  Created by  on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize fontSizeNumberLabel;
@synthesize imageControl;
@synthesize capitalizeSwitch;
@synthesize beatlesImage;
@synthesize titlelabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTitlelabel:nil];
    [self setBeatlesImage:nil];
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

- (IBAction)changeImage:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex]==0) {
        titlelabel.text=@"Young Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    } else if ([sender selectedSegmentIndex]==1){
        titlelabel.text=@"Old Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
        
    }
}

- (IBAction)updateFont:(UISwitch *)sender {
    if (capitalizeSwitch.on) {
        titlelabel.text=[titlelabel.text uppercaseString];
    } else{
        titlelabel.text=[titlelabel.text lowercaseString];
    }
}
- (IBAction)changeFontsize:(UISlider *)sender {
    //get the font size
    int fontSize = sender.value;
    
    //change the font size label
    fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
    
    //create a new font object
    UIFont *newFont = [UIFont systemFontOfSize:sender.value];
    
    //apply the new font to the label
    titlelabel.font=newFont;
}
@end
