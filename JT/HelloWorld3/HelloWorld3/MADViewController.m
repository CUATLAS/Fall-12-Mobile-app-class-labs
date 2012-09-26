//
//  MADViewController.m
//  HelloWorld3
//
//  Created by  on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
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
        messageField.text=@"A Yankee fan, how boring";
    } else if (sender.tag==2) {
        NYImage.image=[UIImage
                       imageNamed:@"metslogo300.png"];
        messageField.text=@"Yay your a Mets Fan";
    }
}
@end
