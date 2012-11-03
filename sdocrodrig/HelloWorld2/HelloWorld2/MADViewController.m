//
//  MADViewController.m
//  HelloWorld2
//
//  Created by new user on 9/20/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize messageText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMessageText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (IBAction)buttonPressed:(UIButton *)sender {
    if (sender.tag==1) {
        messageText.text=@"Salve, Mondo!";
    }else {
        messageText.text=@"Jambo, Nudia!";
    }
}
@end
