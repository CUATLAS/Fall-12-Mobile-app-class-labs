//
//  SSThirdViewController.m
//  Boulder
//
//  Created by Scott Serafin on 10/18/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "SSThirdViewController.h"

@interface SSThirdViewController ()

@end

@implementation SSThirdViewController
@synthesize thirdSpinner, thirdWebView;


- (void)loadWebPageWithString:(NSString *) urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [thirdWebView loadRequest:request];
    
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
    // Do any additional setup after loading the view from its nib.
    
    thirdWebView.delegate = self;
    [self loadWebPageWithString:@"http://www.colorado.edu"];
}

// While the webpage is loading, animate the spinner
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [thirdSpinner startAnimating];
}

// When the webpage finishes loading, stop animating the spinner
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [thirdSpinner stopAnimating];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setThirdWebView:nil];
    [self setThirdSpinner:nil];
    [super viewDidUnload];
}
@end
