//
//  ViewController.m
//  Location
//
//  Created by Stephen Feuerstein on 11/29/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"
#import "Annotation.h"

@interface ViewController ()
{
    CLLocationManager *locationManager;
    Annotation *annotation;
}

@end

@implementation ViewController
@synthesize latitudeLabel, longitudeLabel, accuracyLabel, altitudeLabel;
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    // Map
    mapView.delegate = self;
    mapView.mapType = MKMapTypeHybrid;
    //[self.view addSubview:mapView];
}

#pragma mark CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    latitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    longitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    accuracyLabel.text = [NSString stringWithFormat:@"%f", newLocation.horizontalAccuracy];
    altitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.altitude];
    
    // Update map
    MKCoordinateSpan span;
    span.latitudeDelta = 0.001;
    span.longitudeDelta = 0.001;
    MKCoordinateRegion region;
    region.center = newLocation.coordinate;
    region.span = span;
    [mapView setRegion:region animated:YES];
    
    if (annotation)
    {
        [annotation moveAnnotation:newLocation.coordinate];
    }
    else
    {
        annotation = [[Annotation alloc] initWithCoordinate:newLocation.coordinate];
        [mapView addAnnotation:annotation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Error obtaining location"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark MapKit


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLatitudeLabel:nil];
    [self setLongitudeLabel:nil];
    [self setAltitudeLabel:nil];
    [self setAccuracyLabel:nil];
    [self setMapView:nil];
    [super viewDidUnload];
}
@end
