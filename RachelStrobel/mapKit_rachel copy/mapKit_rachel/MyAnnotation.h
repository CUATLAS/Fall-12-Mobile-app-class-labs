//
//  MyAnnotation.h
//  mapKit_rachel
//
//  Created by Rachel Strobel on 11/29/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
@property (nonatomic, readonly)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coor;
-(void)moveAnnotation: (CLLocationCoordinate2D)newCoordinate;


@end
