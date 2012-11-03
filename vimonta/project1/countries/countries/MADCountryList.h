//
//  MADCountryList.h
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADCountryList : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *gdp;
@property (nonatomic, retain) NSString *population;
@property (nonatomic, retain) NSString *aids;
@property (nonatomic, readwrite) NSInteger countryID;

-(NSInteger) listCount;

@end
