//
//  MADThirdViewController.m
//  Boulder_News
//
//  Created by Jenna Raderstrong on 10/18/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADThirdViewController.h"

@interface MADThirdViewController ()

@end

@implementation MADThirdViewController

//called when page begins to load
@synthesize thirdWebView;
@synthesize thirdSpinner;
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [thirdSpinner startAnimating];
}
//called when page load successfully
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [thirdSpinner stopAnimating];
    
}

-(void)loadWebPageWithString:(NSString *)urlString {
    //The NSString passed should be a properly formed URL
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //constructs a NSURLRequest Object from NSURL object
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
    thirdWebView.delegate=self;
     [self loadWebPageWithString:@"https://news.google.com/?ar=1350577882"];
  
    // Do any additional setup after loading the view from its nib.
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

@end
