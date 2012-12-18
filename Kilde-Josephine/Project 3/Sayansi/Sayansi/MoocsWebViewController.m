//
//  MoocsWebViewController.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/15/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "MoocsWebViewController.h"

@interface MoocsWebViewController ()

@end

@implementation MoocsWebViewController
@synthesize moocsWebView, detailItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

-(void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        detailItem = newDetailItem;
        
    }
}


/*-(void)configureView {
    
    NSURL *url = [NSURL URLWithString:detailItem]; 
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; 
    [self.moocsWebView loadRequest:request]; 
    
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self configureView];
    NSURL *url = [NSURL URLWithString:detailItem];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.moocsWebView loadRequest:request];
}

- (void)viewDidUnload
{
    [self setMoocsWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
