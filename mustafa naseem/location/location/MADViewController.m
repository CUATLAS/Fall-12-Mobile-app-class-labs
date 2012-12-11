//
//  MADViewController.m
//  location
//
//  Created by  on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"
#import "MyAnnotation.h"

@interface MADViewController () {
    CLLocationManager *locationManager;
    MyAnnotation *annotation;
}

@end

@implementation MADViewController
@synthesize latitudeTextField;
@synthesize longitudeTextField;
@synthesize altitudeTextField;
@synthesize accuracyTextField;
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
    
    mapView.delegate=self;
    mapView.mapType=MKMapTypeHybrid;
  //  [self.view addSubview:mapView];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    latitudeTextField.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    longitudeTextField.text=[[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
    altitudeTextField.text=[[NSString alloc] initWithFormat:@"%f", newLocation.altitude];
    accuracyTextField.text=[[NSString alloc] initWithFormat:@"%f", newLocation.horizontalAccuracy];
    
    MKCoordinateSpan span; 
    span.latitudeDelta=.001;
    span.longitudeDelta=.001;
    MKCoordinateRegion region;
    region.center=newLocation.coordinate;
    region.span=span;
    [mapView setRegion:region animated:YES];
    if (annotation) {
        [annotation moveAnnotation:newLocation.coordinate];
    }
    else {
        annotation = [[MyAnnotation alloc] initWithCoordinate:newLocation.coordinate];
        [mapView addAnnotation:annotation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error 
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error obtaining location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidUnload
{
    [self setLatitudeTextField:nil];
    [self setLongitudeTextField:nil];
    [self setAltitudeTextField:nil];
    [self setAccuracyTextField:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
