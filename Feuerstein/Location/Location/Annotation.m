//
//  Annotation.m
//  Location
//
//  Created by Stephen Feuerstein on 11/29/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate;
@synthesize title, subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
    title = @"You are here";
    subtitle = [NSString stringWithFormat:@"Latitude: %f, Longitude: %f", coordinate.latitude, coordinate.longitude];
    return self;
}

-(void)moveAnnotation:(CLLocationCoordinate2D)newCoord
{
    [self willChangeValueForKey:@"coordinate"];
    [self willChangeValueForKey:@"subtitle"];
    coordinate = newCoord;
    subtitle = [NSString stringWithFormat:@"Latitude: %f, Longitude: %f", coordinate.latitude, coordinate.longitude];
    [self didChangeValueForKey:@"coordinate"];
    [self didChangeValueForKey:@"subtitle"];
}

@end
