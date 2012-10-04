//
//  MADViewController.m
//  GNAR2
//
//  Created by Chris Giersch on 10/2/12.
//  Copyright (c) 2012 Chris Giersch. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize spinner;
@synthesize webview;
@synthesize toolbar;
@synthesize pointTotalLabel;
@synthesize nakedSexControl;
@synthesize cliffDropControl;
@synthesize avalancheSwitch;
@synthesize buriedSwitch;
@synthesize injurySwitch;

bool nakedYet, cliffYet = NO;
int cliffSegmentSelected;

// UIWebViewDelegate method called when the web page doesn't load successfully
-(void)webview:(UIWebView *)webview didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error loading web page"
                                                      message:[error localizedDescription] // NSError translates error messAGES INTO THE USER'S LANGUAGE
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK", nil];
    [alertView show]; //send the show message to display the alertView
}

// Load a new web page in the web view
- (void)loadWebPageWithString:(NSString *)urlString
// The NSString passed should be a properly formed URL
{
    NSURL *url = [NSURL URLWithString:urlString]; // an NSURL object is initiated using an NSString
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; // Constructs an NSURLRequest object
    [webview loadRequest:request]; // Loads an NSURLRequest object
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    webview.delegate=self;
    //[self loadWebPageWithString:@"http://unofficialnetworks.com/gnar/"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarnin {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPointTotalLabel:nil];
    [self setNakedSexControl:nil];
    [self setCliffDropControl:nil];
    [self setAvalancheSwitch:nil];
    [self setBuriedSwitch:nil];
    [self setInjurySwitch:nil];
    [self setWebview:nil];
    [self setToolbar:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
}

- (void)updatePointTotal: (int)points;
{
    int myTotal = [pointTotalLabel.text intValue];  // Convert strings to ints
    int myNewTotal = myTotal + points;  // Add points to total
    NSString* myString = [NSString stringWithFormat:@"%d", myNewTotal];    // convert int to string
    pointTotalLabel.text = myString;
}

- (IBAction)updateNakedPoints:(UISegmentedControl *)sender {
    if (!nakedYet) {
        if ([sender selectedSegmentIndex]==0) {
            // Add 5000 points to totalPoints
            [self updatePointTotal:5000];
        }
        else if ([sender selectedSegmentIndex]==1) {
            // Add 10000 points to totalPoints
            [self updatePointTotal:10000];
        }
    }
    else {
        if ([sender selectedSegmentIndex]==0) {
            // +5000 - 10000 = -5000 points to totalPoints
            [self updatePointTotal:-5000];
        }
        else if ([sender selectedSegmentIndex]==1) {
            // +10000 -5000 = 5000 points to totalPoints
            [self updatePointTotal:5000];
        }
    }
    nakedYet = YES;
}
    
- (IBAction)updateCliffPoints:(UISegmentedControl *)sender {
    if (!cliffYet) {
        if ([sender selectedSegmentIndex]==0) // if LOW snow depth
        {
            // Add 750 points to totalPoints
            [self updatePointTotal:750];
            cliffSegmentSelected = 0;
        }
        else if ([sender selectedSegmentIndex]==1) // if MED snow depth
        {
            // Add 500 points to totalPoints
            [self updatePointTotal:500];
            cliffSegmentSelected = 1;
        }
        else if ([sender selectedSegmentIndex]==2) // if HIGH snow depth
        {
            [self updatePointTotal:250];
            cliffSegmentSelected = 2;
        }
    }
    else {
        if ([sender selectedSegmentIndex]==0) {
            [self updatePointTotal:750];
            if (cliffSegmentSelected == 1) {
                [self updatePointTotal:-500];
            }
            else {
                [self updatePointTotal:-250];
            }
            cliffSegmentSelected = 0; }
        else if([sender selectedSegmentIndex]==1) {
            [self updatePointTotal:500];
            if (cliffSegmentSelected==0) {
                [self updatePointTotal:-750];
            }
            else {
                [self updatePointTotal:-250];
            }
            cliffSegmentSelected = 1; }
        else {
            [self updatePointTotal:250];
            if (cliffSegmentSelected==0) {
                [self updatePointTotal:-750];
            }
            else {
                [self updatePointTotal:-500];
            }
            cliffSegmentSelected = 2;
        }
    }
    cliffYet = YES;
}
- (IBAction)updateAvalanchePoints:(UISwitch *)sender {
    if (avalancheSwitch.on) {
        // Add 1000 points to totalPoints
        [self updatePointTotal:1000];
    }
    if (!avalancheSwitch.on) {
        // Subtract 1000 points back from totalPoints
        [self updatePointTotal:-1000];
    }
}
- (IBAction)updateBuriedPoints:(id)sender {
    if (buriedSwitch.on) {
        // Subtract 1000 points from totalPoints
        [self updatePointTotal:-1000];
    }
    if (!buriedSwitch.on) {
        // Add 1000 points back onto totalPoints
        [self updatePointTotal:1000];
    }
}
- (IBAction)updateInjuryPoints:(UISwitch *)sender {
    if (injurySwitch.on) {
        // Subtract 2000 points from totalPoints
        [self updatePointTotal:-2000];
    }
    if (!injurySwitch.on) {
        // Add 2000 points back onto totalPoints
        [self updatePointTotal:2000];
    }
}
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender {
    // Creates the action sheet
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:nil
                                otherButtonTitles:@"GNAR The Movie", @"Squallywood", @"Back to GNAR!", nil];
    [actionSheet showFromToolbar:toolbar];// Displays the action sheet from the toolbar
}

// UIActionSheetDelegate Method - Called when a selection is made on an action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0) {
        webview.hidden=NO;
        [self loadWebPageWithString:@"http://unofficialnetworks.com/gnar/"];
    }
    else if(buttonIndex==1) {
        webview.hidden=NO;
        [self loadWebPageWithString:@"http://www.squallywood.com/"];
    }
    else if(buttonIndex==2) {
        webview.hidden=YES;
    }
}

// UIWebViewDelegate method that is called when a web page begins to load
-(void)webViewDidStartLoad:(UIWebView *)webview
{
    [spinner startAnimating]; // Sends the startAnimating massage to the spinner
}

// UIWebViewDelegate method that is called when a web page loads successfully
-(void)webViewDidFinishLoad:(UIWebView *)webview
{
    [spinner stopAnimating]; // Send the stopAnimating message to the spinner
}

@end
