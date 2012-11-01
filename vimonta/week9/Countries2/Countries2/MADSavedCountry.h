//
//  MADSavedCountry.h
//  Countries2
//
//  Created by Aaron Vimont on 10/30/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADSavedCountry : NSObject
@property (strong, nonatomic) NSString *countryName;
@property (nonatomic) BOOL *didJustFlip;

+ (MADSavedCountry *) sharedInstance;

@end
