//
//  MADViewController.m
//  helloworld
//
//  Created by  on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"
// Improts header file

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize messageText;
// @synthesize goes with @property to create setter and getter methods

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
    //messageText.text=@"Hello World";
    //@ always before quotes for string
    
    NSString *title=[sender titleForState:UIControlStateNormal];
    messageText.text=[NSString stringWithFormat:@"%@ World!", title];
    //%@ picks the name of the label (in this case Goodbye) and adds World at the end
    
}
@end
