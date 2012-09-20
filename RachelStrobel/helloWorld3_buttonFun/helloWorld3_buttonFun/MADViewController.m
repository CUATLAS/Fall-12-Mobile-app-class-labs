//
//  MADViewController.m
//  helloWorld3_buttonFun
//
//  Created by Rachel Strobel on 9/19/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize nyTeamImage;
@synthesize messageField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNyTeamImage:nil];
    [self setMessageField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)chooseTeam:(UIButton *)sender {
    if(sender.tag == 1){
        nyTeamImage.image = [UIImage imageNamed:@"Yankees-logo-300x300.png"];
        messageField.text=@"A Yankee fan, how boring";
    } else {
        nyTeamImage.image = [UIImage imageNamed:@"metslogo300.png"];
        messageField.text = @"Yeah, you're a Mets fan";
    }

}
@end
