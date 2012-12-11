//
//  MADViewController.m
//  Location
//
//  Created by Aaron Vimont on 11/29/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"
#import "MyAnnotation.h"

@interface MADViewController () {
    CLLocationManager *locationManager;
    MyAnnotation *annotation;
}

@end

@implementation MADViewController
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize altitudeLabel;
@synthesize accuracyLabel;
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [locationManager startUpdatingLocation];
    
    mapView.delegate = self;
    mapView.mapType = MKMapTypeHybrid;
}

- (void)viewDidUnload
{
    [self setLatitudeLabel:nil];
    [self setLongitudeLabel:nil];
    [self setAltitudeLabel:nil];
    [self setAccuracyLabel:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - CLLocation Manager Delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    latitudeLabel.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    longitudeLabel.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
    altitudeLabel.text = [[NSString alloc] initWithFormat:@"%f", newLocation.altitude];
    accuracyLabel.text = [[NSString alloc] initWithFormat:@"%f", newLocation.horizontalAccuracy];
    
    // update map
    MKCoordinateSpan span;          // defines the area spanned by the map region
    span.latitudeDelta = 0.001;     // amount of north-to-south distance (in degrees)
    span.longitudeDelta = 0.001;    // amount of east-to-west distance (in degrees)
    
    MKCoordinateRegion region;              // region of the map to be displayed
    region.center = newLocation.coordinate; // sets the center of the region to be newLocation
    region.span = span;                     // animates changing the currently visible location
    
    [mapView setRegion:region animated:YES];
    
    // display annotation
    if (annotation) {
        [annotation moveAnnotation:newLocation.coordinate];
    }
    else {
        annotation = [[MyAnnotation alloc] initWithCoordinate:newLocation.coordinate];
        [mapView addAnnotation:annotation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error obtaining location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
