//
//  MADViewController.m
//  SS_Beatles
//
//  Created by Scott Serafin on 9/13/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize switch_label;
@synthesize font_size_label;
@synthesize age_control;
@synthesize beatles_image;
@synthesize title_label;
@synthesize capital_switch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBeatles_image:nil];
    [self setTitle_label:nil];
    [self setAge_control:nil];
    [self setSwitch_label:nil];
    [self setFont_size_label:nil];
    [self setCapital_switch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)update_image{
    if (age_control.selectedSegmentIndex==0){
        title_label.text=@"young beatles";
        beatles_image.image=[UIImage imageNamed:@"beatles1.png"];
    } else if (age_control.selectedSegmentIndex==1) {
        title_label.text=@"old beatles";
        beatles_image.image=[UIImage imageNamed:@"beatles2.png"];
    }
}

- (void)update_caps{
    if (capital_switch.isOn){
        title_label.text=[title_label.text uppercaseString];
        switch_label.text=@"UPPERCASE";
    } else {
        title_label.text=[title_label.text lowercaseString];
        switch_label.text=@"lowercase";
    }
}

- (IBAction)age_selector:(UISegmentedControl *)sender {
    [self update_image];
    [self update_caps];
}


- (IBAction)capital_switch:(UISwitch *)sender
{
    [self update_caps];
}

- (IBAction)text_slider:(UISlider *)sender {
    // Get the value from the slider and set it to a variable
    int font_size = sender.value;
    
    // Change the fontsize label
    font_size_label.text=[NSString stringWithFormat:@"%d", font_size];
    
    // Create a new font object
    UIFont *new_font = [UIFont systemFontOfSize:sender.value];
    
    // Apply the new font to the label
    title_label.font=new_font;
}





/* OLD CODE BEFORE CONDENSING CODE INTO OTHER FUNCTIONS


// Change the image based on the segmeneted controller value
- (IBAction)age_selector:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex]==0){
        title_label.text=@"Young Beatles";
        beatles_image.image=[UIImage imageNamed:@"beatles1.png"];
    } else if ([sender selectedSegmentIndex]==1) {
        title_label.text=@"Old Beatles";
        beatles_image.image=[UIImage imageNamed:@"beatles2.png"];
    }
}

- (IBAction)text_slider:(UISlider *)sender {
    // Get the value from the slider and set it to a variable
    int font_size = sender.value;
    
    // Change the fontsize label
    font_size_label.text=[NSString stringWithFormat:@"%d", font_size];
    
    // Create a new font object
    UIFont *new_font = [UIFont systemFontOfSize:sender.value];
    
    // Apply the new font to the label
    title_label.font=new_font;
}

- (IBAction)capital_switch:(UISwitch *)sender {
    if (sender.isOn) {
        title_label.text=[title_label.text uppercaseString];
        switch_label.text=@"UPPERCASE";
    } else {
        title_label.text=[title_label.text lowercaseString];
        switch_label.text=@"lowercase";
    }
}
*/


@end
