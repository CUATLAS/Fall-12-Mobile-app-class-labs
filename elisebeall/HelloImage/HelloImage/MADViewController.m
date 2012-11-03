//
//  MADViewController.m
//  HelloImage
//
//  Created by Elise J Beall on 9/25/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize messageField;
@synthesize image;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setImage:nil];
    [self setMessageField:nil];
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
        image.image=[UIImage imageNamed:@"Yankees-logo-300x300.png"];
        messageField.text=@"They seem like a popular team...";
    }else {
        image.image=[UIImage imageNamed:@"metslogo300.png"];
        messageField.text=@"I know nothing about baseball.";
    }
}
@end
