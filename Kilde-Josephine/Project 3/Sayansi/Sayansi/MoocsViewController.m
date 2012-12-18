//
//  MoocsViewController.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "MoocsViewController.h"
#import "MoocsListViewController.h"

@interface MoocsViewController ()

@end

@implementation MoocsViewController

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
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)sitesButtonPressed:(UIButton *)sender {
    MoocsListViewController *moocsListViewController = [[MoocsListViewController alloc]init];
    moocsListViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    NSLog(@"before view controller");
    [self presentViewController:moocsListViewController animated:YES completion:NULL];
}
@end
