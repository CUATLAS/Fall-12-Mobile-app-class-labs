//
//  ViewController.m
//  HelloWorld3
//
//  Created by Stephen Feuerstein on 9/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize teamLabel;
@synthesize teamChosen;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    teamLabel.text = @"Please select a team...";
    self.teamChosen = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UIButton *otherButton = nil;
    
    if (teamChosen)
    {
        // Yankees Button
        if (button.tag == 1)
        {
            otherButton = (UIButton *)[self.view viewWithTag:2];
            otherButton.alpha = 255;
            button.center = CGPointMake(75, 100);
        }
        
        // Sox Button
        if (button.tag == 2)
        {
            otherButton = (UIButton *)[self.view viewWithTag:1];
            otherButton.alpha = 255;
            button.center = CGPointMake(245, 100);
        }
        
        button.transform = CGAffineTransformMakeScale(1,1);
        teamLabel.text = @"Please select a team...";
        teamChosen = NO;
        return;
    }
    
    // Yankees Button
    if (button.tag == 1)
    {
        teamLabel.text = @"Yankees? BOO!\n Tap the team logo to go back to selection";
        otherButton = (UIButton *)[self.view viewWithTag:2];
        teamChosen = YES;
    }
    
    // Sox Button
    if (button.tag == 2)
    {
        teamLabel.text = @"Sox? YAY!\n Tap the team logo to go back to selection";
        otherButton = (UIButton *)[self.view viewWithTag:1];
        teamChosen = YES;
    }
    
    // Adjust Buttons
    otherButton.alpha = 0;
    button.transform = CGAffineTransformMakeScale(2,2);
    button.center = CGPointMake(self.view.frame.size.width/2, button.center.y);
    //button.frame = CGRectMake(button.center.x, button.center.y, 320, 320);
}

-(void)dealloc
{
    teamLabel = nil;
}

@end
