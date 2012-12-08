//
//  MADViewController.h
//  mapKit_rachel
//
//  Created by Rachel Strobel on 11/29/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface MADViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
