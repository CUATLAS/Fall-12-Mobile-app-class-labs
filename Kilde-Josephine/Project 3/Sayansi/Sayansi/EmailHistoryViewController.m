//
//  EmailHistoryViewController.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/16/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "EmailHistoryViewController.h"

@interface EmailHistoryViewController ()

@end

@implementation EmailHistoryViewController
@synthesize emailSpinner;
@synthesize historyWebView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

-(void)webViewDidStarLoad:(UIWebView *)webView
{
    [emailSpinner startAnimating]; 
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [emailSpinner stopAnimating]; 
}

- (void)viewDidUnload
{
    [self setHistoryWebView:nil];
    [self setEmailSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
