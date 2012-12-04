//
//  MADViewController.m
//  Location
//
//  Created by  on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"
#import "MyAnnotation.h"

@interface MADViewController (){
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
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; //Specify the desired accuracy
    locationManager.distanceFilter = kCLDistanceFilterNone; //Specify the distance a device must move literally (in meters) to generate an update. We specify to be notified of all movements.
    [locationManager startUpdatingLocation]; //Starts the location manager
    mapView.delegate = self;
    mapView.mapType = MKMapTypeHybrid; //Hybrid with map and satellite
    
 
}

#pragma mark CLLocationManager Delegate Methods

//Called when a new location is available
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    latitudeTextField.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude]; //Assign the latitude a string to the text field
    longitudeTextField.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude]; //Assign the longitude a string to the text field
    altitudeTextField.text = [[NSString alloc] initWithFormat:@"%f", newLocation.altitude]; //Assign the altitude a string to the text field
    accuracyTextField.text = [[NSString alloc] initWithFormat:@"%f", newLocation.horizontalAccuracy]; //Assign the accuracy a string to the text field
    
    //Update the map
    MKCoordinateSpan span; //Defines the area spanned by a map region
    span.latitudeDelta = .001; //The amount of north-to-south distance (measured in degrees) to display on the map
    span.longitudeDelta = .001; //The amount of east-to-west distance (measured in degrees) to display for the map of the region
    MKCoordinateRegion region; //Region of the map to be displayed
    region.center = newLocation.coordinate; //Sets the center of the region to be the newLocation
    region.span = span; //Sets the horizontal and vertical span of the map to display
    [mapView setRegion:region animated:YES]; //Animates changing the curently visible region
    
    //Display annotation
    if (annotation) {
        [annotation moveAnnotation:newLocation.coordinate]; //Moves the annotation if it already exists
    }
    else 
    {
        //Creates an annotation if one does not exist
        annotation = [[MyAnnotation alloc] initWithCoordinate:newLocation.coordinate]; //Creates new annotation
        [mapView addAnnotation:annotation]; //Adds the annotation to the mapview
    }
}

//Called when a location cannot be determined
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Error obtaining location"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
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
