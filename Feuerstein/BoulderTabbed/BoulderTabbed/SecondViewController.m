//
//  SecondViewController.m
//  BoulderTabbed
//
//  Created by Stephen Feuerstein on 10/18/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize webViewObject;
@synthesize spinnerObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadWebPageWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webViewObject loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadWebPageWithString:@"http://www.bouldercolorado.gov"];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinnerObject startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinnerObject stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebViewObject:nil];
    [self setSpinnerObject:nil];
    [super viewDidUnload];
}
@end
