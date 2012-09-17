//
//  MADViewController.m
//  Hello_World_4
//
//  Created by Scott Serafin on 9/11/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize NYImage;
@synthesize message_field;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNYImage:nil];
    [self setMessage_field:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)choose_team:(UIButton *)sender {
    if (sender.tag==1) {
        NYImage.image=[UIImage imageNamed:@"yankees.png"];
        message_field.text=@"A Yankees fan, lol.";
    }else {
        NYImage.image=[UIImage imageNamed:@"mets.png"];
        message_field.text=@"Cool, a mets fan.";
    }
    
}
@end
