//
//  MADViewController.m
//  Favorites
//
//  Created by Elise J Beall on 10/11/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import "MADViewController.h"
#import "InfoViewController.h"

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self setWordLabel:nil];
    [self setQuoteText:nil];
}

- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"info button tapped");
    //initialize view controller
    InfoViewController *infoViewController=[[InfoViewController alloc]init];
    //set transition style to flip horizontal transition
    infoViewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    //present the inforViewController
    [self presentViewController:infoViewController animated:YES completion:NULL];
}
@end
