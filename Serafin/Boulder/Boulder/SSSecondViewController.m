//
//  SSSecondViewController.m
//  Boulder
//
//  Created by Scott Serafin on 10/18/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "SSSecondViewController.h"

@interface SSSecondViewController ()

@end

@implementation SSSecondViewController
@synthesize secondSpinner, secondWebView;


- (void)loadWebPageWithString:(NSString *) urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [secondWebView loadRequest:request];
    
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
    
    secondWebView.delegate = self;
    [self loadWebPageWithString:@"http://www.bouldercolorado.gov/"];
}

// While the webpage is loading, animate the spinner
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [secondSpinner startAnimating];
}

// When the webpage finishes loading, stop animating the spinner
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [secondSpinner stopAnimating];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSecondWebView:nil];
    [self setSecondSpinner:nil];
    [super viewDidUnload];
}
@end
