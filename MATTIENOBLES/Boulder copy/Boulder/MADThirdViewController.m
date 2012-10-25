//
//  MADThirdViewController.m
//  Boulder
//
//  Created by Mattie Nobles on 10/18/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "MADThirdViewController.h"

@interface MADThirdViewController ()

@end

@implementation MADThirdViewController
@synthesize thirdWebView;
@synthesize thirdSpinner;

-(void) loadWebPageWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [thirdWebView loadRequest:request];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    thirdWebView.delegate=self;
    [self loadWebPageWithString:@"http://cargocollective.com/mattienobles"];
    // Do any additional setup after loading the view from its nib.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [thirdSpinner startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [thirdSpinner stopAnimating];
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
