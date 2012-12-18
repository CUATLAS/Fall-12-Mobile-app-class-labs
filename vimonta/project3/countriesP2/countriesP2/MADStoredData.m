//
//  MADStoredData.m
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADStoredData.h"

@implementation MADStoredData

@synthesize currentSegment, oldSegment, lowValue, highValue;

+(MADStoredData *) sharedInstance {
    static MADStoredData *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        myInstance.currentSegment   = -1;
        myInstance.oldSegment       = 0;
        myInstance.lowValue         = 0.0;
        myInstance.highValue        = 0.0;
    }
    return myInstance;
}


@end
