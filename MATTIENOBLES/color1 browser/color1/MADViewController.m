//
//  MADViewController.m
//  color1
//
//  Created by Mattie Nobles on 10/2/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize colorMessage;
@synthesize webView;
@synthesize spinner;
@synthesize toolbar;
@synthesize colorImage;

- (void) loadWebPageWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*webView.delegate=self;
    [self loadWebPageWithString:@"http://www.flagco.com/pdfs/pantonecolorchart.pdf"];*/
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setColorImage:nil];
    [self setColorMessage:nil];
    [self setWebView:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)colorCombo:(UIButton *)sender {
    if (sender.tag==1){
        colorImage.image=[UIImage imageNamed:@"grey-blue.png"];
        colorMessage.text=@"Simple, Trendy!";
    } else if (sender.tag==2){
        colorImage.image=[UIImage imageNamed:@"bluegrey:blue.png"];
        colorMessage.text=@"Darker, but they vibrate dont they?!";
    }
    else {
        colorImage.image=[UIImage imageNamed:@"allthreecolors.png"];
        colorMessage.text=@"All three do have a nice balance!";
    }
}
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"COLORS", nil];
    [actionSheet showFromToolbar:toolbar];

}
- (void) actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self loadWebPageWithString:@"http://www.flagco.com/pdfs/pantonecolorchart.pdf"];
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinner startAnimating];
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
}

@end
