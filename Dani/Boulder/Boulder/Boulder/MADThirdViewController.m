//
//  MADThirdViewController.m
//  Boulder
//
//  Created by new user on 10/18/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import "MADThirdViewController.h"

@interface MADThirdViewController ()

@end

@implementation MADThirdViewController
@synthesize thirdWebView;
@synthesize thirdSpinner;


-(void)loadWebPageWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString]; 
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; 
    [thirdWebView loadRequest:request]; 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    thirdWebView.delegate=self;
    [self loadWebPageWithString:@"http://www.colorado.edu/"];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
	[thirdSpinner startAnimating];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[thirdSpinner stopAnimating];
}

- (void)viewDidUnload
{
    [self setThirdSpinner:nil];
    [self setThirdWebView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
