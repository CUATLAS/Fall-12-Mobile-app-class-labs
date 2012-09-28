//
//  HWLViewController.m
//  Browser
//
//  Created by  on 9/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController
@synthesize webView;
@synthesize toolbar;
@synthesize spinner;

//UIWebViewDelegate method called when web page doesn't load successfully
-(void)webView: (UIWebView *) webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error loading webpage" message:[error localizedDescription] //NSError translates error messages into user's language
                                                     delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show]; //send the show message to display the alertView
}
//load a new webpage in webview
-(void) loadWebPageWithString: (NSString *) urlString
//The NSString passed should be a properly formed URL
{
    NSURL *url = [NSURL URLWithString:urlString]; //NSURL object is initialized using a NSString that is passed to the method
    NSURLRequest *request= [NSURLRequest requestWithURL:url]; //constructs a NSURLRequest object from a NSURL object
    [webView loadRequest:request]; //loads NSURLRequest  Object
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    webView.delegate=self; //sets the controller as the delegate of the UIWebView instance
    [self loadWebPageWithString:@"http:redwood.colorado.edu/apierce/mad/fall12"];
    //Do any additional setup after loading the view, typically from a nib
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

- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    //creates the action sheet
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"ATLAS", @"Boing Boing", @"CU", nil];
    [actionSheet showFromTabBar:toolbar];
    //displays the action sheet from the toolbar
}
//UIActionSheetDelegate Method
//called when a selection is made on an action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {   
        [self loadWebPageWithString:@"http:atlas.colorado.edu"];
    }
    else if (buttonIndex==1)
    {
        [self loadWebPageWithString:@"http:boingboing.net"];
    }
    else if (buttonIndex==2) {
        [self loadWebPageWithString:@"http:www.colorado.edu"];
    }
}

//UIWebViewDelegate method that is called when a webpage begins to load
-(void)webViewDidStartLoad:(UIWebView *)webView 
{
    [spinner startAnimating]; //sends the startAnimating message to teh spinner
}
//UIWebViewDelegate method that is called when a webpage loads successfully
-(void)webViewDidFinishLoad:(UIWebView *)webView
{ 
    [spinner stopAnimating]; //sends the stop animating message to the spinner
}
@end
