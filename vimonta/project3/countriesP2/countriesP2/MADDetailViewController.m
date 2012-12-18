//
//  MADDetailViewController.m
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADDetailViewController.h"

@interface MADDetailViewController () {
    MKPointAnnotation *annotationPoint;
}

@end

@implementation MADDetailViewController
@synthesize countryArray;
@synthesize portrait;
@synthesize landscape;
@synthesize mapView;
@synthesize mapSpinner;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [mapView removeAnnotation:annotationPoint];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    annotationPoint = [[MKPointAnnotation alloc] init];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"longCountryListPlist" ofType:@"plist"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    countryArray = [dictionary objectForKey:self.title];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

- (void)viewDidUnload
{
    [self setPortrait:nil];
    [self setLandscape:nil];
    [self setMapView:nil];
    [self setMapSpinner:nil];
    [super viewDidUnload];
    countryArray = nil;
    annotationPoint = nil;
}

#pragma mark - Map Method

- (void) setUpMap {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.title completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            for (CLPlacemark *aPlacemark in placemarks) {
                CLLocationDegrees latitude = aPlacemark.location.coordinate.latitude;
                CLLocationDegrees longitude = aPlacemark.location.coordinate.longitude;
                countryCoords = CLLocationCoordinate2DMake(latitude, longitude);
                
                annotationPoint.coordinate = countryCoords;
                annotationPoint.title = self.title;
                
                // set view region to 1000 miles
                MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(countryCoords, 1000*METERS_PER_MILE, 200*METERS_PER_MILE);
                MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
                
                // set region and add annotation
                [mapView setRegion:adjustedRegion animated:YES];
                [mapView setCenterCoordinate:countryCoords];
                [mapView addAnnotation:annotationPoint];
                
                // stop spinner and fade to map
                [mapSpinner stopAnimating];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                [mapView setAlpha:1.0];
                [mapSpinner setAlpha:0.0];
                [UIView commitAnimations];
                [mapView setHidden:NO];
            }
        }
        else {
            // an error occured, set the view to the world and show the alert view
            MKCoordinateRegion viewRegion = MKCoordinateRegionMake(mapView.centerCoordinate, MKCoordinateSpanMake(180, 360));
            [mapView setRegion:viewRegion];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:@"Please reload the map" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}

#pragma mark - Rotation Methods

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [mapView setAlpha:0.0];
        [mapView setHidden:YES];
        
        self.view = self.portrait;
        self.view.transform = CGAffineTransformIdentity;
        //self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0 ));
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        //self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
        [UIView commitAnimations];
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [mapSpinner setAlpha:1.0];
        [mapSpinner startAnimating];
        [self setUpMap];
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view = self.landscape;
        
        self.view.transform = CGAffineTransformIdentity;
        //self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
        [UIView commitAnimations];
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [mapSpinner setAlpha:1.0];
        [mapSpinner startAnimating];
        [self setUpMap];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return  [countryArray count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        // remove any whitespace and convert GDP string to number with decimal style (add a comma every three numbers)
        NSString *trimmedString = [[countryArray objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSInteger intNum = [trimmedString integerValue];
        NSNumber *myNum = [[NSNumber alloc] initWithInteger:intNum];
        
        NSString *formattedNum = [formatter stringFromNumber:myNum];
        
        // add dollar sign to beginning of string
        NSMutableString *dollarSign = [[NSMutableString alloc] initWithString:@"$"];
        [dollarSign appendString:formattedNum];
        
        cell.textLabel.text = dollarSign;
    }
    else if (indexPath.section == 1) {
        // remove any whitespace and convert GDP string to number with decimal style (add a comma every three numbers)
        NSString *trimmedString = [[countryArray objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSInteger intNum = [trimmedString integerValue];
        NSNumber *myNum = [[NSNumber alloc] initWithInteger:intNum];
        
        NSString *formattedNum = [formatter stringFromNumber:myNum];
        
        cell.textLabel.text = formattedNum;
    }
    else if (indexPath.section == 2) {
        NSMutableString *percentSign = [[NSMutableString alloc] initWithString:[countryArray objectAtIndex:2]];
        
        // if string does not contain NA, append % sign
        if ([[countryArray objectAtIndex:2] rangeOfString:@"NA"].location == NSNotFound) {
            [percentSign appendString:@"%"];
        }
        
        cell.textLabel.text = percentSign;
    }
    else if (indexPath.section == 3) {
        cell.textLabel.text = @"Rotate to View Map";
    }
    
    return cell;
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName = nil;
    
    switch (section) {
        case 0:
            sectionName = @"GDP per Capita (in U.S. dollars)";
            break;
        case 1:
            sectionName = @"Population";
            break;
        case 2:
            sectionName = @"AIDS Rate (as % of pop)";
            break;
        case 3:
            sectionName = @"On the Map";
            break;
            
        default:
            break;
    }
    
    return sectionName;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
