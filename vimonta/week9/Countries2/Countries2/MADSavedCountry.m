//
//  MADSavedCountry.m
//  Countries2
//
//  Created by Aaron Vimont on 10/30/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADSavedCountry.h"

@implementation MADSavedCountry
@synthesize countryName;
@synthesize didJustFlip;

+(MADSavedCountry *) sharedInstance {
    static MADSavedCountry *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        myInstance.countryName = @"";
        myInstance.didJustFlip = NO;
    }
    return myInstance;
}

@end
