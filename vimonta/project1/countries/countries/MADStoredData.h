//
//  MADStoredData.h
//  countries
//
//  Created by Aaron Vimont on 9/25/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADStoredData : NSObject

@property (nonatomic) NSInteger currentSegment;
@property (nonatomic) float gdpValue;
@property (nonatomic) float popValue;
@property (nonatomic) float aidsValue;
@property (nonatomic) BOOL checkGdp;
@property (nonatomic) BOOL checkPop;
@property (nonatomic) BOOL checkAids;
@property (nonatomic) BOOL skipThisCountry;

+ (MADStoredData *) sharedInstance;

@end
