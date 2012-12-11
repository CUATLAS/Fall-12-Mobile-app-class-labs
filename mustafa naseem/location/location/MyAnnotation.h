//
//  MyAnnotation.h
//  location
//
//  Created by  on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;

-(id) initWithCoordinate: (CLLocationCoordinate2D) coor;
-(void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate;

@end
