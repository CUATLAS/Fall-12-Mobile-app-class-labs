//
//  MADDetailViewController.h
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#define degreesToRadians(x)(M_PI*(x)/180.0)
#define METERS_PER_MILE 1609.344

@interface MADDetailViewController : UITableViewController <MKAnnotation> {
    CLLocationCoordinate2D countryCoords;
    NSString *pinTitle;
}
@property (strong, nonatomic) NSArray *countryArray;
@property (strong, nonatomic) IBOutlet UITableView *portrait;
@property (strong, nonatomic) IBOutlet UIView *landscape;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mapSpinner;

@end
