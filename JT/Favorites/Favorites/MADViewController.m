//
//  MADViewController.m
//  Favorites
//
//  Created by  on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"
#import "infoViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize wordLabel;
@synthesize quoteText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setWordLabel:nil];
    [self setQuoteText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"info button tapped"); //NSLog (@"value%@",variable to test ex=foo); checks to see if variables work. Good way to debug the program. 
    infoViewController *myinfoViewController=[[infoViewController alloc]init];
    myinfoViewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myinfoViewController animated:YES completion:NULL];
}

@end
