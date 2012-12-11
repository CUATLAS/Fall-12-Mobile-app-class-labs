//
//  MADarchive.m
//  Task
//
//  Created by Jenna Raderstrong on 12/11/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADarchive.h"
#define kThing1key @"Thing1"
#define kThing2key @"Thing2"
#define kThing3key @"Thing3"
#define kThing4key @"Thing4"


@implementation MADarchive
@synthesize thing1;
@synthesize thing2;
@synthesize thing3;
@synthesize thing4;

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:thing1 forKey:kThing1key];
    [aCoder encodeObject:thing2 forKey:kThing2key];
    [aCoder encodeObject:thing3 forKey:kThing3key];
    [aCoder encodeObject:thing4 forKey:kThing4key];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
     thing1=[aDecoder decodeObjectForKey:kThing1key];
     thing2=[aDecoder decodeObjectForKey:kThing2key];
     thing3=[aDecoder decodeObjectForKey:kThing3key];
     thing4=[aDecoder decodeObjectForKey:kThing4key];

    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    MADarchive *copy=[[[self class] allocWithZone:zone] init];
    copy.thing1=[self.thing1 copyWithZone:zone];
    copy.thing2=[self.thing2 copyWithZone:zone];
    copy.thing3=[self.thing3 copyWithZone:zone];
    copy.thing4=[self.thing4 copyWithZone:zone];
    return copy;
    
    
}

    
@end







