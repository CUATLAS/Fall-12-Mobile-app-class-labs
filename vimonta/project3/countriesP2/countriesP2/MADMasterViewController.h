//
//  MADMasterViewController.h
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344

@interface MADMasterViewController : UITableViewController <UISearchBarDelegate, MKAnnotation, UIAlertViewDelegate> {
    CLLocationCoordinate2D countryCoords;
    NSString *pinTitle;
}
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) IBOutlet UITableView *portrait;
@property (strong, nonatomic) IBOutlet UIView *landscape;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) BOOL isSearched;
@property (assign, nonatomic) BOOL isFiltered;
@property (assign, nonatomic) BOOL mapHasBeenSetUp;
@property (strong, nonatomic) NSDictionary *filteredCountryData;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mapSpinner;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *) searchTerm;

@end
