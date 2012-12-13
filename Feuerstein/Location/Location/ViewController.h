//
//  ViewController.h
//  Location
//
//  Created by Stephen Feuerstein on 11/29/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
