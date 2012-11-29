//
//  MADViewController.m
//  Location
//
//  Created by Jenna Raderstrong on 11/29/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"
#import "MyAnnotation.h"

@interface MADViewController (){
    CLLocationManager *locationManager;
    MyAnnotation *annotation;
}

@end

@implementation MADViewController
@synthesize latitude;
@synthesize longitude;
@synthesize altitude;
@synthesize accuracy;
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    mapView.delegate=self;
    mapView.mapType=MKMapTypeHybrid;
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    latitude.text=[[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
     longitude.text=[[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
     altitude.text=[[NSString alloc] initWithFormat:@"%f", newLocation.altitude     ];
    accuracy.text=[[NSString alloc] initWithFormat:@"%f", newLocation.horizontalAccuracy];
    MKCoordinateSpan span;
    span.latitudeDelta=.001;
    span.longitudeDelta=.001;
    MKCoordinateRegion region;
    region.center=newLocation.coordinate;
    region.span=span;
    [mapView setRegion:region animated:YES];
    if(annotation){
        [annotation moveAnnotation:newLocation.coordinate];
    }
    else{
        annotation=[[MyAnnotation alloc]initWithCoordinate:newLocation.coordinate];
        [mapView addAnnotation:annotation];
    }
    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error Obtaining Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


- (void)viewDidUnload
{
    [self setLatitude:nil];
    [self setLongitude:nil];
    [self setAltitude:nil];
    [self setAccuracy:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end











