//
//  HWLSecondViewController.m
//  Disability List
//
//  Created by  on 11/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLSecondViewController.h"

@interface HWLSecondViewController ()

@end

@implementation HWLSecondViewController
@synthesize webView;
@synthesize spinner;

-(void)webView: (UIWebView *) webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error loading webpage" message:[error localizedDescription] //NSError translates error messages into user's language
                                                     delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show]; //send the show message to display the alertView
}

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
    [self loadWebPageWithString:@"http://en.wikipedia.org/wiki/Disability"];
    //Do any additional setup after loading the view, typically from a nib
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
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
