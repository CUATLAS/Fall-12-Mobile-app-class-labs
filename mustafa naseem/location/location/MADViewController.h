//
//  MADViewController.h
//  location
//
//  Created by  on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MADViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *latitudeTextField;
@property (weak, nonatomic) IBOutlet UILabel *longitudeTextField;
@property (weak, nonatomic) IBOutlet UILabel *altitudeTextField;
@property (weak, nonatomic) IBOutlet UILabel *accuracyTextField;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
