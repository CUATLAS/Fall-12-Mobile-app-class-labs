//
//  MADViewController.m
//  Browser
//
//  Created by Scott Serafin on 9/20/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize webView;
@synthesize toolbar;
@synthesize status;


// UIWeb page in the webview
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc]
                            initWithTitle:@"Sorry, there was an error loading the webpage."
                            message:[error localizedDescription]  // Show what the actual error was to the user
                            delegate: self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
    
    if ([error code] != NSURLErrorCancelled)
        [alertView show];  // Send the show error message to alert view
}







// Load a new webpage in the webview
- (void)loadWebPage:(NSString *)urlString

// The NSString passed should be a properly formatted URL
{
    // A NSURL object is initialized using a NSString that is passed to the method
    NSURL *url = [NSURL URLWithString:urlString];      NSURLRequest *request =
    
    // Constructs a NSURLRequest object from a NSURL object
    [NSURLRequest requestWithURL:url];
    [webView loadRequest:request]; // Loads a NSURLRequest object
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sets the controller as the delegate of the UIWebViw instance
    webView.delegate = self;
    
    [self loadWebPage:@"http://www.scottserafin.co"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Bookmark Button Actions
- (IBAction)bookmarks:(UIBarButtonItem *)sender {
    // Creates an action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"CNN", @"Google",@"YouTube", nil];
    
    [actionSheet showFromToolbar:toolbar];  // Displays the action sheet from the toolbar
}


// Control the spinner
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [status startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [status stopAnimating];
}


// Setting up the actionshet buttons
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self loadWebPage:@"http://www.cnn.com"];
            break;
        case 1:
            [self loadWebPage:@"http://www.google.com"];
            break;
        case 2:
            [self loadWebPage:@"http://www.youtube.com"];
            break;
            
        default:
            break;
    }
}


@end
