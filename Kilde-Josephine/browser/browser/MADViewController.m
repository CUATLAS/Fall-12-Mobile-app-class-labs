//
//  MADViewController.m
//  browser
//
//  Created by  on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize spinner;
@synthesize webView;
@synthesize toolbar;

//UIWebViewDelegate method called when the web page doesn't load successfully
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error loading web page"
                                                      message:[error localizedDescription]
                                                     //NSError translates error messages into the user's language
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK", nil];
    [alertView show];
    //Send the show message to display the alertView
}

//Load a new web page in the web view
-(void)loadWebPageWithString:(NSString *)urlString
//The NSString passed should be a property formed URL
{
    NSURL *url = [NSURL URLWithString:urlString];
    //A NSURL object is initiated using a NSString that is passed to the method
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //Constructs a NSURLRequest object from a NSURL object
    [webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webView.delegate=self;
    //Sets the controller as the delegate of the UIWebView instance
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

- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    //Creates the action sheet
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"ATLAS",@"TAM", @"CU", nil];
    [actionSheet showFromToolbar:toolbar];
    //Displays the action sheet from the toolbar
}

//UIActionSheetDelegate Method called when a selection is made on an action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self loadWebPageWithString:@"http://atlas.colorado.edu"];
    }
    else if (buttonIndex==1) 
    {
        [self loadWebPageWithString:@"http://tam.colorado.edu"];
    }
    else if (buttonIndex==2) 
    {
        [self loadWebPageWithString:@"http://www.colorado.edu"];
    }

}

//UIWebViewDelegate method that is called when a web page begin to load
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinner startAnimating];
    //Sends the startAnimating message to the spinner
}

//UIWebViewDelegate method that is called when a web page loads successfully
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
    //Sends the stopAnimating message to the spinner
}

@end
