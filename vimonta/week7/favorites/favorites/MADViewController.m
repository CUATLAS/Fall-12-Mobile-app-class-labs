//
//  MADViewController.m
//  favorites
//
//  Created by Aaron Vimont on 10/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
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
    user = [[Favorite alloc] init];
}

- (void)viewDidUnload
{
    [self setWordLabel:nil];
    [self setQuoteText:nil];
    user = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    wordLabel.text = user.word;
    quoteText.text = user.quote;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender {
    
    // initialize view controller
    InfoViewController *infoViewController = [[InfoViewController alloc] init];
    
    // set transition style to flip horizontal transition
    infoViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    infoViewController.userInfo = user;
    
    // present the infoViewController
    [self presentViewController:infoViewController animated:YES completion:NULL];
}
@end
