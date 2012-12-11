//
//  MyAnnotation.m
//  Location
//
//  Created by Aaron Vimont on 11/29/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate, title, subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    coordinate = coord;
    title = @"You are here!";
    subtitle = [NSString stringWithFormat:@"Latitude: %f. Longitude: %f", coordinate.latitude, coordinate.latitude];
    return self;
}

- (void)moveAnnotation:(CLLocationCoordinate2D)newCoord {
    [self willChangeValueForKey:@"coordinate"]; // informs the receiver that the coordinate is about the change
    [self willChangeValueForKey:@"subtitle"];   // informs the receiver that the subtitle is about to change
    
    coordinate = newCoord;
    subtitle = [[NSString alloc] initWithFormat:@"Latitude: %f. Longitude: %f", coordinate.latitude, coordinate.longitude];
    
    [self didChangeValueForKey:@"coordinate"];  // informs the receiver that the coordinate has changed
    [self didChangeValueForKey:@"subtitle"];    // informs the receiver that the subtitle has changed
}

@end
