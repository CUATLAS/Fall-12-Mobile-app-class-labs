//
//  MADViewController.m
//  browser
//
//  Created by Aaron Vimont on 9/20/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize webView;
@synthesize toolbar;
@synthesize spinner;

- (void)loadWebPageWithString: (NSString *)urlString {
    // a NSURL object is initialized using a NSString that is passed to a method
    NSURL *url = [NSURL URLWithString:urlString];
    
    // contructs a NSURLRequest object from a NSURL object
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // loads a NSURL object
    [webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webView.delegate = self;
    [self loadWebPageWithString:@"http://redwood.colorado.edu/apierce/mad/fall12"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setToolbar:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error loading web page!"
                                                      message:[error localizedDescription]
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    // creates an action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Bookmarks"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Atlas", @"TAM", @"CU", nil];
  
    [actionSheet showFromToolbar:toolbar];
}

// UIActionSheetDelegate Method
// called when a selection is made on an action sheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self loadWebPageWithString:@"http://atlas.colorado.edu"];
    }
    else if (buttonIndex == 1) {
        [self loadWebPageWithString:@"http://tam.colorado.edu"];
    }
    else if (buttonIndex == 2) {
        [self loadWebPageWithString:@"http://www.colorado.edu"];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [spinner stopAnimating];
}

@end
