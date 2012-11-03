//
//  MADViewController.m
//  favorites_RachelStrobel
//
//  Created by Rachel Strobel on 10/11/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADViewController.h"
#import "InfoViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize wordLabel;
@synthesize quoteText;

//set the username and userquote just before the view appers
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    wordLabel.text=user.word;
    quoteText.text=user.quote;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    user=[[Favorite alloc] init]; //initializes the user object
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
    NSLog(@"info button tapped");
    //initialize view controller
    InfoViewController *infoViewController=[[InfoViewController alloc] init];
    //set transition style to flip horizontal transition
    infoViewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    infoViewController.userInfo=user; //updates the userInfo property on the infoViewController so it points to the user model
    //present the infoViewController
    [self presentViewController:infoViewController animated:YES completion:NULL];
    
}
    
@end
