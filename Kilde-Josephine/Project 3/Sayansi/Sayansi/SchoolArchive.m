//
//  SchoolArchive.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/17/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "SchoolArchive.h"

#define kNamekey @"Name"
#define kStreetkey @"Street"
#define kCitykey @"City"
#define kCountrykey @"Country"

@implementation SchoolArchive

@synthesize nameTextField, streetTextField, cityTextField, countryTextField;

//NSCoder method to encode objects into an archive
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode the 4 strings in the archive
    [aCoder encodeObject:nameTextField forKey:kNamekey];
    [aCoder encodeObject:streetTextField forKey:kStreetkey];
    [aCoder encodeObject:cityTextField forKey:kCitykey];
    [aCoder encodeObject:countryTextField forKey:kCountrykey];
}

//NSCoder method to decode objects from an archive
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){ //initializes our object
        //decode the 4 strings from the archive
        nameTextField=[aDecoder decodeObjectForKey:kNamekey];
        streetTextField=[aDecoder decodeObjectForKey:kStreetkey];
        cityTextField=[aDecoder decodeObjectForKey:kCitykey];
        countryTextField=[aDecoder decodeObjectForKey:kCountrykey];
    }
    return self;
}

//NSCopy method to copy objects
-(id)copyWithZone:(NSZone *)zone{
    //create a new object and copy the 4 strings into it
    SchoolArchive *copy=[[[self class] allocWithZone:zone]init];
    copy.nameTextField=[self.nameTextField copyWithZone:zone];
    copy.streetTextField=[self.streetTextField copyWithZone:zone];
    copy.cityTextField=[self.cityTextField copyWithZone:zone];
    copy.countryTextField=[self.countryTextField copyWithZone:zone];
    return copy;
}

@end
