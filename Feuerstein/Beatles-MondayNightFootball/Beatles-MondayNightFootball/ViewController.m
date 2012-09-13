//
//  ViewController.m
//  Beatles-MondayNightFootball
//
//  Created by Stephen Feuerstein on 9/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize broncosImage, falconsImage, vsLabel, fontLabel;
@synthesize capsSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkForCaps
{
    if (capsSwitch.isOn)
        vsLabel.text = [vsLabel.text uppercaseString];
    else
        vsLabel.text = [vsLabel.text lowercaseString];
}

- (IBAction)teamControlValueChanged:(UISegmentedControl *)sender
{
    switch ([sender selectedSegmentIndex])
    {
        // Broncos
        case 0:
        {
            // Update images
            falconsImage.alpha = 0;
            broncosImage.alpha = 255;
            
            // vsLabel
            vsLabel.text = @"Broncos";
            [self checkForCaps];
        }
            break;
        // Falcons
        case 1:
        {
            // Update images
            broncosImage.alpha = 0;
            falconsImage.alpha = 255;
            
            // vsLabel
            vsLabel.text = @"Falcons";
            [self checkForCaps];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)capsSwitchedChanged:(UISwitch *)sender
{
    [self checkForCaps];
}

- (IBAction)fontSizeChanged:(UISlider *)sender
{
    fontLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    vsLabel.font = [UIFont systemFontOfSize:sender.value];
}
@end
