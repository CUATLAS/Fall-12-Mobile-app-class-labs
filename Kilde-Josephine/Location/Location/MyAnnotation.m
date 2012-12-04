//
//  MyAnnotation.m
//  Location
//
//  Created by  on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate, title, subtitle;

//Initializes an annotation instance
-(id)initWithCoordinate: (CLLocationCoordinate2D) coor {
    coordinate = coor;
    title = @"You are here";
    subtitle = [NSString stringWithFormat:@"Latitude: %f. Longitude: %f", coordinate.latitude, coordinate.longitude];
    return self;
}

//Changes location of the annotation
-(void)moveAnnotation: (CLLocationCoordinate2D) newCoordinate {
    [self willChangeValueForKey:@"coordinate"]; //Informas the receiver that the coordinate is about to change
    [self willChangeValueForKey:@"subtitle"]; //Informas the receiver that the subtitle is about to change
    coordinate = newCoordinate;
    subtitle = [[NSString alloc] initWithFormat:@"Latitude: %f. Longitude: %f", coordinate.latitude, coordinate.longitude];
    [self didChangeValueForKey:@"coordinate"]; //Informs the receiver that the coordinate has changed
    [self didChangeValueForKey:@"subtitle"]; //Informs the receiver tht the subtite has changed
}
@end
