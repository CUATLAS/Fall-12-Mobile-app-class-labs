//
//  ViewController.m
//  Browser
//
//  Created by Stephen Feuerstein on 9/20/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize webView, toolbar;
@synthesize spinner;

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
// Show an alert view when there is an error with loading
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Error loading page..."
                              message:[error localizedDescription]
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
    
    // If loading canceled by going to a different page, ignore
    if ([error code] != NSURLErrorCancelled)
        [alertView show];
}

// Update activity spinner
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    spinner.hidden = NO;
    [spinner startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
    spinner.hidden = YES;
}

-(void)loadWebPageWithString:(NSString *)urlString
// Load the web page given a url string
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    webView.delegate = self;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self loadWebPageWithString:@"http://www.colorado.edu"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [self setToolbar:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
}

- (IBAction)bookmarkButtonTapped:(id)sender
// Display bookmarks when button tapped
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"ATLAS", @"TAM", @"CU", nil];
    [actionSheet showFromToolbar:toolbar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *urlString = nil;
    
    switch (buttonIndex) {
        // ATLAS
        case 0:
            urlString = @"http://atlas.colorado.edu";
            break;
        // TAM
        case 1:
            urlString = @"http://tam.colorado.edu/";
            break;
        // CU
        case 2:
            urlString = @"http://www.colorado.edu";
            break;
            
        default:
            break;
    }
    
    if (urlString)
        [self loadWebPageWithString:urlString];
}

@end
