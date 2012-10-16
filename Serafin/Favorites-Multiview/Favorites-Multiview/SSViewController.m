//
//  SSViewController.m
//  Favorites-Multiview
//
//  Created by Scott Serafin on 10/11/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "SSViewController.h"
#import "SSInfoViewController.h"
#import "SSFavorite.h"

@interface SSViewController ()
{
    SSFavorite *user;
}
@end

@implementation SSViewController
@synthesize wordLabel;
@synthesize quoteText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    user = [[SSFavorite alloc] init];  // Initializes the user object
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    wordLabel.text = user.word;
    quoteText.text = user.quote;
}


- (void)viewDidUnload
{
    [self setWordLabel:nil];
    [self setQuoteText:nil];
    user = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"Info button tapped");
    
    // Initialize the view controller
    SSInfoViewController *ssInfoViewController = [[SSInfoViewController alloc] init];

    // Set transition style to flip horizontal
    ssInfoViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    ssInfoViewController.userInfo = user;
    
    // Present the view controller
    [self presentViewController:ssInfoViewController animated:YES completion:NULL];
}


@end
