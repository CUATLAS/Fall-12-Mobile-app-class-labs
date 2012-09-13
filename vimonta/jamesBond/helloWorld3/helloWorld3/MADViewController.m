//
//  MADViewController.m
//  helloWorld3
//
//  Created by Aaron Vimont on 9/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize bondImage;
@synthesize messageField;
@synthesize pierceBtn;

bool pierceWasClicked = false;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMessageField:nil];
    [self setBondImage:nil];
    [self setBondImage:nil];
    [self setPierceBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)chooseBond:(UIButton *)sender {
    if (sender.tag == 2) {
        if (pierceWasClicked == false) {
            bondImage.image = [UIImage imageNamed:@"pierce.jpg"];
            messageField.text = @"Let's try that again...";
            pierceWasClicked = true;
        } else if (pierceWasClicked == true) {
            messageField.text = @"I am clearly the better choice";
            bondImage.image = [UIImage imageNamed:@"seanConnery.jpg"];
            [sender setTitle:@"Revoked" forState: UIControlStateNormal];
            [sender setEnabled:NO];
        }
    } else {
        bondImage.image = [UIImage imageNamed:@"seanConnery.jpg"];
        messageField.text = @"A wise choice my friend";
        pierceWasClicked = false;
    }
}

- (IBAction)reset:(UIButton *)sender {
    bondImage.image = [UIImage imageNamed:@"bothSeanAndPierce.jpg"];
    [pierceBtn setTitle:@"Pierce Brosnan" forState: UIControlStateNormal];
    [pierceBtn setEnabled:YES];
    pierceWasClicked = false;
}

@end
