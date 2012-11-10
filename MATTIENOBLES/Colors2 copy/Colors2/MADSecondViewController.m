//
//  MADSecondViewController.m
//  Colors2
//
//  Created by Mattie Nobles on 11/4/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "MADSecondViewController.h"

@interface MADSecondViewController ()

@end

@implementation MADSecondViewController
@synthesize secondWebView;
@synthesize secondSpinner;

-(void) loadWebPageWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [secondWebView loadRequest:request];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    secondWebView.delegate=self;
    [self loadWebPageWithString:@"https://kuler.adobe.com/"];
    // Do any additional setup after loading the view from its nib.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [secondSpinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [secondSpinner stopAnimating];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
