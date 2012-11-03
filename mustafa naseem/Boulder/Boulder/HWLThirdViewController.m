//
//  HWLThirdViewController.m
//  Boulder
//
//  Created by  on 10/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLThirdViewController.h"

@interface HWLThirdViewController ()

@end

@implementation HWLThirdViewController
@synthesize thirdWebView;
@synthesize thirdSpinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadWebPageWithString: (NSString *) urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    [thirdWebView loadRequest:reqest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadWebPageWithString:@"http:colorado.edu/"];
}

- (void)viewDidUnload
{
    [self setThirdWebView:nil];
    [self setThirdSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)webViewDidStartLoad:(UIWebView *) webView {
[thirdSpinner startAnimating];
}

-(void)webViewDidFinishLoad: (UIWebView *) webView {
[thirdSpinner stopAnimating];
}

@end
