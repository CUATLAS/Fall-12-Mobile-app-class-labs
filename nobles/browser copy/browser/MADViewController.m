//
//  MADViewController.m
//  browser
//
//  Created by Mattie Nobles on 9/20/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize spinner;
@synthesize webView;
@synthesize toolbar;

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{ UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error loading web page"
                                                    message:[error localizedDescription]
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void) loadWebPageWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webView.delegate=self;
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"ATLAS", @"TAM", @"CU",@"HOME", nil];
    [actionSheet showFromToolbar:toolbar];
}

- (void) actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
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
    else if (buttonIndex==3)
    {
        [self loadWebPageWithString:@"http://redwood.colorado.edu/apierce/mad/fall12"];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinner startAnimating];
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
}

@end
