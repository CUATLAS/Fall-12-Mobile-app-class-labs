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
@synthesize fontSizeNumLabel;
@synthesize capSwitch;
@synthesize imageControl;
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
    [self setCapSwitch:nil];
    [self setFontSizeNumLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)changedImage:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0)
    {
        titleLabel.text = @"Young Beatles";
        beatlesImage.image = [UIImage imageNamed:@"beatles1.png"];
    }
    else if ([sender selectedSegmentIndex] == 1)
    {
        titleLabel.text = @"Old Beatles";
        beatlesImage.image = [UIImage imageNamed:@"beatles2.png"];
    }
    
}
- (IBAction)updateFont:(UISwitch *)sender {
    if (capSwitch.on)
    {
        titleLabel.text = [titleLabel.text uppercaseString];
        
    }
    else {
        titleLabel.text = [titleLabel.text lowercaseString];
    }
}
- (IBAction)scaleFont:(UISlider *)sender {
    int fontSize = sender.value;
    fontSizeNumLabel.text = [NSString stringWithFormat:@"%d", fontSize];
    UIFont *newFont = [UIFont systemFontOfSize:fontSize];
    titleLabel.font = newFont;
}
@end
