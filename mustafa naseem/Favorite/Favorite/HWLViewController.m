//
//  HWLViewController.m
//  Favorite
//
//  Created by  on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"
#import "InfoViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize wordLabel;
@synthesize quoteText;


-(void)viewWillAppear:(BOOL)animated { 
    [super viewWillAppear:YES];
    wordLabel.text=user.word;
    quoteText.text=user.quote;
}
    
    
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    user=[[Favorite alloc] init];
}

- (void)viewDidUnload
{
    [self setWordLabel:nil];
    [self setQuoteText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    user=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"Info button tapped");
    
    InfoViewController *myInfoViewController = [[InfoViewController alloc] init];
    
    myInfoViewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    
    myInfoViewController.userInfo=user;
    
    [self presentViewController:myInfoViewController animated:YES completion:NULL];
}
@end
