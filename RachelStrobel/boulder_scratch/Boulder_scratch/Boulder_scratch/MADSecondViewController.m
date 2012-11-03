//
//  MADSecondViewController.m
//  Boulder_scratch
//
//  Created by Rachel Strobel on 10/18/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADSecondViewController.h"

@interface MADSecondViewController ()

@end

@implementation MADSecondViewController
@synthesize secondWebView;
@synthesize secondSpinner;

//load a new web page in the web view
-(void) loadWebPageWithString: (NSString *) urlString {
    //The NSString passed should be a properly formed URL
    NSURL *url = [NSURL URLWithString:urlString];//a NSURL object is initiatlized using a NSString that is passed to the method
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//contructs a NSURLRequest object from a NSURL object
    [secondWebView loadRequest:request];//loads a NSURLRequest object
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    secondWebView.delegate=self;
    [self loadWebPageWithString:@"http://www.bouldercolorado.gov/"];
    // Do any additional setup after loading the view from its nib.
}
//UIWebViewDelegate method that is called when a web page begins to load
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [secondSpinner startAnimating]; //sends the startAnimating message to the spinner
}
//UIWebViewDelegate method that is called when a web page loads successfully
-(void)webViewDidFinishLoad: (UIWebView *)webView
{
    [secondSpinner stopAnimating];//sends the stopAnimating message to the spinner
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
