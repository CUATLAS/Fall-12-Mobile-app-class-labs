//
//  SchoolNameViewController.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SchoolNameViewController : UIViewController <MKMapViewDelegate> 

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (nonatomic) IBOutlet UIBarButtonItem *saveButtonPressed;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end
