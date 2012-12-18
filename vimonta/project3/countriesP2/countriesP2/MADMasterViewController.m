//
//  MADMasterViewController.m
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADMasterViewController.h"
#import "MADDetailViewController.h"
#import "MADStoredData.h"

@interface MADMasterViewController () {
    NSDictionary *countryData;
    NSMutableDictionary *searchedCountryData;
    NSTimer *timer;
    
    //MKPointAnnotation *annotationPoint;
    NSMutableArray *annotationPoints;
    NSInteger numberOfPinTries;
    NSInteger numberOfAttemptedMapLoads;
    BOOL showMapHowTo;
    
    MADDetailViewController *detailViewController;
}

@end

@implementation MADMasterViewController
@synthesize search;
@synthesize portrait;
@synthesize landscape;
@synthesize mapView;
@synthesize isSearched;
@synthesize isFiltered;
@synthesize filteredCountryData;
@synthesize mapSpinner;
@synthesize mapHasBeenSetUp;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    search.delegate = self;
    numberOfAttemptedMapLoads = 0;
    numberOfPinTries = 0;
    showMapHowTo = YES;
    
    self.navigationController.navigationBar.hidden = NO;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"longCountryListPlist" ofType:@"plist"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    countryData = dictionary;
    self.title = @"Countries";
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0.0, 44.0) animated:NO];
}

- (void)viewDidUnload
{
    [self setSearch:nil];
    [self setPortrait:nil];
    [self setLandscape:nil];
    [self setMapView:nil];
    [self setMapSpinner:nil];
    [super viewDidUnload];
    countryData = nil;
    searchedCountryData = nil;
    filteredCountryData = nil;
    search = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [search resignFirstResponder];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    // show alert view telling user how to find map
    if (showMapHowTo && isFiltered) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"On the Map" message:@"Rotate left or right to see these countries on the map!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Don't Show", nil];
        [alertView show];
    }
    
    // check orientation for landscape and non-filtered list
    if (!isFiltered) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(onTimer)
                                               userInfo:nil
                                                repeats:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // remove annotations from map
    [mapView removeAnnotations:annotationPoints];
    mapHasBeenSetUp = NO;
}

- (void)onTimer {
    if (!isFiltered) {
        // bring up alert view if orientation is landscape
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Not Available" message:@"The map view is not available for the full country list. Please use the inputs on the starting page to filter the results." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alertView show];
            
            [timer invalidate];
        }
    }
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        showMapHowTo = NO;
    }
}

#pragma mark - Map methods

- (void)stopSpinningAndShowMap {
    [mapSpinner stopAnimating];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [mapView setAlpha:1.0];
    [mapSpinner setAlpha:0.0];
    [UIView commitAnimations];
    [mapView setHidden:NO];
}

- (void) setUpMap {
    numberOfPinTries = 0;
    // if the map has tried to load 5 times, show alert view
    if (numberOfAttemptedMapLoads == 4) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:@"Please reload the map" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alertView show];
        
        numberOfAttemptedMapLoads = 0;
        return;
    }
    
    // clear annotation
    if ([annotationPoints count] > 0) {
        [mapView removeAnnotations:annotationPoints];
    }
    
    // set view region to whole world map
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(mapView.centerCoordinate, MKCoordinateSpanMake(180, 360));
    [mapView setRegion:viewRegion];
    
    annotationPoints = nil;
    annotationPoints = [[NSMutableArray alloc] init];
    
    for (NSString *key in filteredCountryData) {
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        
        [geocoder geocodeAddressString:key completionHandler:^(NSArray *placemarks, NSError *error) {
            numberOfPinTries++;
            
            if (!error) {
                for (CLPlacemark *aPlacemark in placemarks) {
                    CLLocationDegrees latitude = aPlacemark.location.coordinate.latitude;
                    CLLocationDegrees longitude = aPlacemark.location.coordinate.longitude;
                    countryCoords = CLLocationCoordinate2DMake(latitude, longitude);
                    
                    annotationPoint.coordinate = countryCoords;
                    annotationPoint.title = key;
                    [annotationPoints addObject:annotationPoint];
                    
                    // check if all pins have been tried
                    if ((numberOfPinTries == [filteredCountryData count]) &&
                        ([annotationPoints count] < [filteredCountryData count])) {
                        // geocode failed, try to reload the map
                        numberOfAttemptedMapLoads++;
                        [self setUpMap];
                    }
                    
                    // check if all pins have successfully been added
                    if ([annotationPoints count] == [filteredCountryData count]) {
                        // all geocodes succeed, show the map
                        mapHasBeenSetUp = YES;
                        [self stopSpinningAndShowMap];
                    } else {
                        mapHasBeenSetUp = NO;
                    }
                    
                    [mapView addAnnotation:annotationPoint];
                }
            }
            else {
                // not all pins were added, try to reload map
                if (numberOfPinTries == [filteredCountryData count]) {
                    numberOfAttemptedMapLoads++;
                    [self setUpMap];
                }
            }
        }];
    }
}

#pragma mark - Rotation methods

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [mapView setAlpha:0.0];
        [mapView setHidden:YES];
        
        self.view = self.portrait;
        self.view.transform = CGAffineTransformIdentity;
        //self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0 ));
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
        [self.tableView setContentOffset:CGPointMake(0.0, 44.0) animated:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        //self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        if (!mapHasBeenSetUp) {
            [mapSpinner setAlpha:1.0];
            [mapSpinner startAnimating];
            [self setUpMap];
        }
        else {
            [mapView setAlpha:1.0];
            [mapView setHidden:NO];
        }
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        //self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        if (!mapHasBeenSetUp) {
            [mapSpinner setAlpha:1.0];
            [mapSpinner startAnimating];
            [self setUpMap];
        }
        else {
            [mapView setAlpha:1.0];
            [mapView setHidden:NO];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    if (isFiltered) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearched) {
        return [searchedCountryData count];
    }
    else if (isFiltered) {
        return [filteredCountryData count];
    }
    else {
        return [countryData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *rowData = [[NSArray alloc] init];
    if (isSearched) {
        rowData = [[searchedCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    else if (isFiltered) {
        rowData = [[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    else {
        rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }

    cell.textLabel.text = [rowData objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!detailViewController) {
        detailViewController = [[MADDetailViewController alloc] initWithNibName:@"MADDetailViewController" bundle:nil];
    }
    
    NSArray *rowData = [[NSArray alloc] init];
    if (isSearched) {
        rowData = [[searchedCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    else if (isFiltered) {
        rowData = [[filteredCountryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    else {
        rowData = [[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    
    detailViewController.title = [rowData objectAtIndex:indexPath.row];
    detailViewController.countryArray = [countryData objectForKey:detailViewController.title];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Search Bar Delegate methods

- (void)resetSearch {
    searchedCountryData = nil;
    isSearched = NO;
}

- (void)handleSearchForTerm:(NSString *)searchTerm {
    isSearched = YES;
    searchedCountryData = [[NSMutableDictionary alloc] init];
    NSArray *rowData = [[NSArray alloc] initWithArray:[[countryData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    NSUInteger i;
    
    for (i = 0; i < [rowData count]; i++) {
        NSRange nameRange = [[rowData objectAtIndex:i] rangeOfString:searchTerm options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [searchedCountryData setObject:[countryData objectForKey:[rowData objectAtIndex:i]] forKey:[rowData objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchTerm = [searchBar text];
    [self handleSearchForTerm:searchTerm];
    [search resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        [self resetSearch];
        [self.tableView reloadData];
        return;
    }
    [self handleSearchForTerm:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    search.text = @"";
    [self resetSearch];
    [search resignFirstResponder];
    [self.tableView reloadData];
}

#pragma mark - Touch Handler

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] != search) {
        [search resignFirstResponder];
    }
}

@end
