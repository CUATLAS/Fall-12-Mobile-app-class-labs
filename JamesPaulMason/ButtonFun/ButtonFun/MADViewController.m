//
//  MADViewController.m
//  ButtonFun
//
//  Created by James Mason on 9/4/12.
//  Copyright (c) 2012 Trinary. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize labelText;


- (void)viewDidUnload
{
    //[self setLabelText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    labelText.text = [NSString stringWithFormat:@"%@ button pressed.", title]; 
}
@end
