//
//  MADStoredData.h
//  countriesP2
//
//  Created by Aaron Vimont on 10/31/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADStoredData : NSObject

@property (nonatomic) NSInteger currentSegment;
@property (nonatomic) NSInteger oldSegment;
@property (nonatomic) float lowValue;
@property (nonatomic) float highValue;

+ (MADStoredData *) sharedInstance;

@end
