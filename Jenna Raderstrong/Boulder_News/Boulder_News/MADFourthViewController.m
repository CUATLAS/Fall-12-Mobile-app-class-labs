//
//  MADFourthViewController.m
//  Boulder_News
//
//  Created by Jenna Raderstrong on 10/18/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADFourthViewController.h"

@interface MADFourthViewController ()

@end

@implementation MADFourthViewController
@synthesize fourthWebView;
@synthesize fourthSpinner;


-(void)loadWebPageWithString:(NSString *)urlString {
    //The NSString passed should be a properly formed URL
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //constructs a NSURLRequest Object from NSURL object
    [fourthWebView loadRequest:request];
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
    fourthWebView.delegate=self;
    [self loadWebPageWithString:@"http://www.npr.org/?refresh=true"];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setFourthWebView:nil];
    [self setFourthSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [fourthSpinner startAnimating];
}
//called when page load successfully
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [fourthSpinner stopAnimating];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
