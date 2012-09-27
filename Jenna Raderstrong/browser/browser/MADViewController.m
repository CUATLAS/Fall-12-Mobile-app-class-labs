//
//  MADViewController.m
//  browser
//
//  Created by Jenna Raderstrong on 9/20/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize spinner;
@synthesize webView;
@synthesize toolBar;

//UIWebViewDelegate method called when web page does not load
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Oops Try Again!" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    [alertView show];
}
//load a new web page
-(void)loadWebPageWithString:(NSString *)urlString
//the NSString passed should be a properly formed URL
{
    NSURL *url = [ NSURL URLWithString: urlString]; //a NSURL object is initialized using a NSString that is passed to the method
    NSURLRequest *request=[NSURLRequest requestWithURL:url]; //constructs a NSURLRequest object from a NSURL Object
    [webView loadRequest:request]; //loads NSURLREquest object
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadWebPageWithString:@"http://redwood.colorado.edu/apierce/mad/fall12"];
    webView.delegate=self;
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setToolBar:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate: self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"ATLAS", @"TAM", @"CU", nil];
    [actionSheet showFromToolbar:toolBar];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex){
 
        case 0:
    
        [self loadWebPageWithString:@"http://atlas.colorado.edu"];
    
  
        case 1:
    
        [self loadWebPageWithString:@"http://tam.colorado.edu"];
    

        case 2:
    
        [self loadWebPageWithString:@"http://www.colorado.edu"];}
    
    
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinner startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
}
@end





