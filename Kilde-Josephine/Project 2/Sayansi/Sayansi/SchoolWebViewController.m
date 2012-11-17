//
//  SchoolWebViewController.m
//  Sayansi
//
//  Created by  on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SchoolWebViewController.h"


@interface SchoolWebViewController ()

@end

@implementation SchoolWebViewController

@synthesize schoolWebPage;
@synthesize detailItem;

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


-(void)configureView {
    //Update user interface for the detail item
    NSURL *url = [NSURL URLWithString:detailItem]; //A NSURL object is initialized using the url detail item
        NSURLRequest *request = [NSURLRequest requestWithURL:url]; //Constructs a NSURLRequest object from NSURL object
    [self.schoolWebPage loadRequest:request]; //Loads a NSURLRequest object
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
       
}

- (void)viewDidUnload
{
    [self setSchoolWebPage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
/*
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
}*/


- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissModalViewControllerAnimated:YES];}
@end
