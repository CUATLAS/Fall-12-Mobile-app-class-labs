//
//  HWLViewController.m
//  Hello World 3
//
//  Created by  on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize NYImage;
@synthesize messageField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNYImage:nil];
    [self setMessageField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

    
- (IBAction)chooseTeam:(UIButton *)sender {
    if (sender.tag==1) {
        NYImage.image=[UIImage imageNamed:@"Yankees-logo-300x300.png"];
        messageField.text=@"A Yankee fan, how awesome!";
    }else {
        NYImage.image=[UIImage imageNamed:@"metslogo300.png"];
        messageField.text=@"You're a Mets fan, how boring";
    }
}
@end
