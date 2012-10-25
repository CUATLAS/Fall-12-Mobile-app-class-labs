//
//  MADsecondViewController.m
//  boulder
//
//  Created by  on 10/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADsecondViewController.h"

@interface MADsecondViewController ()

@end

@implementation MADsecondViewController
@synthesize secondWebView;
@synthesize secondSpinner;

//Load a new webpage in the web view
-(void)loadWebPageWithString: (NSString *)urlString {
    //NSString pssed should be a properly formed url
    NSURL *url = [NSURL URLWithString:urlString]; //A NSURL object is initialized using a NSString that is passed to the method
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; //Constructs a NSURLRequest object from a NSURL object 
    [secondWebView loadRequest:request]; //Loads a NSURLRequest object
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    secondWebView.delegate=self;
    [self loadWebPageWithString:@"http://www.bouldercolorado.gov/"];
}

//UIWebViewDelegate method that is called when a web page begins to load
-(void)webViewDidStarLoad:(UIWebView *)webView
{
    [secondSpinner startAnimating]; //Sends the startAnimating message to the spinner
}

//UIWebViewDelegate method that is called when a web page loads successfully
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [secondSpinner stopAnimating]; //Sends the stopAnimating message to the spinner
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload
{
    [self setSecondWebView:nil];
    [self setSecondSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
