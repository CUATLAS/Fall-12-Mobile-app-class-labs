//
//  Annotation.h
//  Location
//
//  Created by Stephen Feuerstein on 11/29/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface Annotation : NSObject <MKAnnotation>

@property(nonatomic, readonly)CLLocationCoordinate2D coordinate;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord;
-(void)moveAnnotation:(CLLocationCoordinate2D)newCoord;

@end
