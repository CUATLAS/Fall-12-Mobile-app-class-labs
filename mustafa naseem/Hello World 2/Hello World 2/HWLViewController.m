//
//  HWLViewController.m
//  Hello World 2
//
//  Created by  on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@implementation HWLViewController
@synthesize messageText;

- (void)viewDidUnload
{
    [self setMessageText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateNormal ];
    messageText.text = [ NSString stringWithFormat:@"%@ World", title];
}
@end
