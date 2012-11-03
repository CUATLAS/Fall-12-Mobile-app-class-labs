//
//  MADStoredData.m
//  countries
//
//  Created by Aaron Vimont on 9/25/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADStoredData.h"

@implementation MADStoredData
@synthesize currentSegment, checkGdp, checkPop, checkAids, skipThisCountry;

+(MADStoredData *) sharedInstance {
    static MADStoredData *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        myInstance.currentSegment = -1;
        myInstance.checkGdp = NO;
        myInstance.checkPop = NO;
        myInstance.checkAids = NO;
        myInstance.skipThisCountry = NO;
        myInstance.gdpValue = 10000;
        myInstance.popValue = 50000000;
        myInstance.aidsValue = 0.5;
    }
    return myInstance;
}

@end
