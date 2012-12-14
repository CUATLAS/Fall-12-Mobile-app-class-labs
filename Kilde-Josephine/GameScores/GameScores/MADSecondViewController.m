//
//  MADSecondViewController.m
//  GameScores
//
//  Created by  on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADSecondViewController.h"

@interface MADSecondViewController ()

@end

@implementation MADSecondViewController
@synthesize gameWeb;
@synthesize gameSpinner;

-(void)loadPageWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [gameWeb loadRequest:request];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gameWeb.delegate = self;
    [self  loadPageWithString:@"http://www.scrabble.com"];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [gameSpinner startAnimating];
}

-(void)webDidFinishLoad:(UIWebView *)webView
{
    [gameSpinner stopAnimating];
}
- (void)viewDidUnload
{
    [self setGameWeb:nil];
    [self setGameSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
