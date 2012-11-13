//
//  MADMapViewController.m
//  Project2
//
//  Created by Rachel Strobel on 10/25/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADMapViewController.h"

@interface MADMapViewController ()

@end

@implementation MADMapViewController
@synthesize mapWebView;
@synthesize mapSpinner;

//load a new web page in the web view
-(void) loadWebPageWithString: (NSString *) urlString {
    //The NSString passed should be a properly formed URL
    NSURL *url = [NSURL URLWithString:urlString];//a NSURL object is initiatlized using a NSString that is passed to the method
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//contructs a NSURLRequest object from a NSURL object
    [mapWebView loadRequest:request];//loads a NSURLRequest object
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
    mapWebView.delegate=self;
    [self loadWebPageWithString:@"http://www.slaverymap.org/"];
    // Do any additional setup after loading the view from its nib.
}

//UIWebViewDelegate method that is called when a web page begins to load
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [mapSpinner startAnimating]; //sends the startAnimating message to the spinner
}

//UIWebViewDelegate method that is called when a web page loads successfully
-(void)webViewDidFinishLoad: (UIWebView *)webView
{
    [mapSpinner stopAnimating];//sends the stopAnimating message to the spinner
}

- (void)viewDidUnload
{
    [self setMapWebView:nil];
    [self setMapSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation !=UIInterfaceOrientationPortraitUpsideDown);
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


@end
