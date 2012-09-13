//
//  MADViewController.m
//  noblesBeatles9-13
//
//  Created by Mattie Nobles on 9/13/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize fontSizeNumberLabel;
@synthesize imageControl;
@synthesize capSwitch;
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
    [self setFontSizeNumberLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
//change image becomes
/*-(void) updateImage{
  if (imageControl.selectedSegmentIndex==0) {
    titleLabel.text=@"Baby Beatles";
    beatlesImage.image=[UIImage imageNamed:@beatles1.png"];
}   else if 
 //
 */
- (IBAction)changeImage:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex]==0) {
        titleLabel.text=@"Baby Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles1.png"];
    } else if ([sender selectedSegmentIndex]==1) {
        titleLabel.text=@"Old Beatles";
        beatlesImage.image=[UIImage imageNamed:@"beatles2.png"];
    }
}

- (IBAction)updateFont:(UISwitch *)sender {
    if (capSwitch.on) {
        titleLabel.text=[titleLabel.text uppercaseString];
    } else{
        titleLabel.text=[titleLabel.text lowercaseString];
    }
}
- (IBAction)changeFontSize:(UISlider *)sender {
    int fontSize = sender.value;
    fontSizeNumberLabel.text=[NSString stringWithFormat:@"%d", fontSize];
    UIFont *newFont = [UIFont systemFontOfSize:sender.value];
    titleLabel.font=newFont;
}
@end
