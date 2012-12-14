//
//  MADThirdViewController.m
//  boulder
//
//  Created by Josephine Kilde on 12/14/12.
//
//

#import "MADThirdViewController.h"

@interface MADThirdViewController ()

@end

@implementation MADThirdViewController
@synthesize cuWebView;
@synthesize cuSpinner;

//Load CU web page
-(void)loadWebPageWithString: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [cuWebView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cuWebView.delegate=self;
    [self loadWebPageWithString:@"http://www.colorado.edu"];
    // Do any additional setup after loading the view from its nib.
}

//Method called when web page begins to load
-(void)webViewDidStarLoad:(UIWebView *)webView
{
    [cuSpinner startAnimating];
}

//Method caled when web page loads uccessfully
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [cuSpinner stopAnimating]; 
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
    [self setCuWebView:nil];
    [self setCuSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
