//
//  MADHomeViewController.m
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADHomeViewController.h"
#import "MADMasterViewController.h"
#import "MADParser.h"

@interface MADHomeViewController ()

@end

@implementation MADHomeViewController
@synthesize masterViewController;
@synthesize theSegment;
@synthesize infoLabel;
@synthesize earthImage;

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
}

- (void)viewDidUnload
{
    [self setTheSegment:nil];
    [self setInfoLabel:nil];
    [self setEarthImage:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    // handle orientation if view loads in landscape mode
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    [self adjustViewsForOrientation:orientation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self adjustViewsForOrientation:toInterfaceOrientation];
}

- (void) adjustViewsForOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        earthImage.center = CGPointMake(90.0f, 150.0f);
    }
    else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        earthImage.center = CGPointMake(165.0f, 140.0f);
    }
}

- (IBAction)showTheTable:(UIButton *)sender {
    
    // Load the XML file
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"longCountryList.xml"];
    
    // create data object
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    // create xmlParser
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    
    MADParser *theParser = [[MADParser alloc] initParser];
    
    [xmlParser setDelegate:theParser];
    
    // parse the file
    BOOL worked = [xmlParser parse];
    
    if (worked) {
        NSLog(@"Success!");
    } else {
        NSLog(@"Oh dear... it failed");
    }
    
    // push and load the table view
    MADMasterViewController *masterView = [[MADMasterViewController alloc] init];
    [self.navigationController pushViewController:masterView animated:YES];
    
}

- (IBAction)segmentPressed:(UISegmentedControl *)sender {
    [MADStoredData sharedInstance].currentSegment = sender.selectedSegmentIndex;
    switch (sender.selectedSegmentIndex) {
        case 0:
            infoLabel.text = @"Select countries with a GDP per capita greater than $10,000";
            break;
        case 1:
            infoLabel.text = @"Select countries with a population greater than 50 million";
            break;
        case 2:
            infoLabel.text = @"Select countries with an AIDS rate greater than 0.5%";
            break;
            
        default:
            break;
    }
}

- (IBAction)resetTable:(UIButton *)sender {
    [theSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [MADStoredData sharedInstance].currentSegment = -1;
    infoLabel.text = @"List of all countries";
}
@end
