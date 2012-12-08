//
//  MADViewController.m
//  mapKit_rachel
//
//  Created by Rachel Strobel on 11/29/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADViewController.h"
#import "MyAnnotation.h"

@interface MADViewController (){
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
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    mapView.delegate=self;
    mapView.mapType=MKMapTypeHybrid;
    [self.view addSubview:mapView]; 
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

#pragma mark CLLocationManager Delegate methods

-(void)locationManager:(CLLocationManager *)manager
didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *) oldLocation{
    latitudeLabel.text=[[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    longitudeLabel.text=[[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
    altitudeLabel.text=[[NSString alloc] initWithFormat:@"%f", newLocation.altitude];
    accuracyLabel.text=[[NSString alloc]initWithFormat:@"%f", newLocation.horizontalAccuracy];
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
        annotation=[[MyAnnotation alloc] initWithCoordinate:newLocation.coordinate];
        [mapView addAnnotation:annotation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
                                                  message:@"Error obtaining location"
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
