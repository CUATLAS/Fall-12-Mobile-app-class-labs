//
//  MADViewController.m
//  Bowswer Browser
//
//  Created by James Mason on 9/25/12.
//  Copyright (c) 2012 Trinary. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize webView, spinner, toolBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    webView.delegate = self;
    [self loadWebpageWithString:@"http://www.cracked.com/article_18863_5-reasons-bowser-most-successful-video-game-character.html"];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setToolBar:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)bookmarksButtonTapped:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Mario", @"Bowser", @"Yoshi", nil];
    [actionSheet showFromToolbar:toolBar];
}

#pragma mark -
#pragma mark Web View Delegate Methods
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error loading webpage"
                                                    message:[error localizedDescription] // Write to user's language
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

// Load webpage to the user's view
- (void)loadWebpageWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
}

#pragma mark -
#pragma mark Action Sheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self loadWebpageWithString:@"http://mario.nintendo.com/"];
    }
    else if (buttonIndex == 1) {
        [self loadWebpageWithString:@"http://en.wikipedia.org/wiki/Bowser_(character)"];
    }
    else if (buttonIndex == 2) {
        [self loadWebpageWithString:@"http://en.wikipedia.org/wiki/Yoshi"];
    }
}

@end