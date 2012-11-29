//
//  MADViewController.h
//  Location
//
//  Created by Jenna Raderstrong on 11/29/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MADViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UITextField *altitude;
@property (weak, nonatomic) IBOutlet UITextField *accuracy;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
