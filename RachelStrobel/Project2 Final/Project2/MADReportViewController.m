//
//  MADReportViewController.m
//  Project2
//
//  Created by Rachel Strobel on 10/24/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADReportViewController.h"

@interface MADReportViewController ()

@end

@implementation MADReportViewController

//Main picture of Lisset in the .xib file was taken from website:https://www.facebook.com/FundacionReintegraAC?fref=ts and modified in photoshop

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return (interfaceOrientation !=UIInterfaceOrientationPortraitUpsideDown);
}

//the code for the following two actions is from tutorial info on url: http://stackoverflow.com/questions/6101286/making-a-button-call-a-phone-number-in-xcode


//This is my phone number. Feel free to call it to check out the action
- (IBAction)callphone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:9703970183"]];
}

- (IBAction)visitWebsite:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://fundacionreintegra.org.mx/"]];
}


@end
