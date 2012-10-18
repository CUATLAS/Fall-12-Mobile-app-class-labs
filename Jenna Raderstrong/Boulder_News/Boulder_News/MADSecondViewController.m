//
//  MADSecondViewController.m
//  Boulder_News
//
//  Created by Jenna Raderstrong on 10/18/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADSecondViewController.h"

@interface MADSecondViewController ()

@end

@implementation MADSecondViewController
@synthesize secondWebView;
@synthesize secondSpinner;

-(void)loadWebPageWithString:(NSString *)urlString {
    //The NSString passed should be a properly formed URL
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //constructs a NSURLRequest Object from NSURL object
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
    secondWebView.delegate=self;
    [self loadWebPageWithString:@"http://www.reuters.com/"];
    // Do any additional setup after loading the view from its nib.
}

//called when page begins to load
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [secondSpinner startAnimating];
}
//called when page load successfully
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [secondSpinner stopAnimating];
    
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
