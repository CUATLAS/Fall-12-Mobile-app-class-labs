//
//  MyAnnotation.m
//  Location
//
//  Created by Jenna Raderstrong on 11/29/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate, title, subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coor{
    coordinate=coor;
    title=@"You are Here";
    subtitle=[NSString stringWithFormat:@"Latitude: %f. Longitude: %f", coordinate.latitude, coordinate.longitude];
    return self;
}
-(void)moveAnnotation:(CLLocationCoordinate2D)newcoordinate {
    [self willChangeValueForKey:@"coordinate"];
    [self willChangeValueForKey:@"subtitle"];
    coordinate=newcoordinate;
    subtitle=[NSString stringWithFormat:@"Latitude: %f. Longitude: %f", coordinate.latitude, coordinate.longitude];
    [self didChangeValueForKey:@"coordinate"];
    [self didChangeValueForKey:@"subtitle"];
}
@end
