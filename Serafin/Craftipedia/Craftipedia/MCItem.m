//
//  items.m
//  Craftipedia
//
//  Created by Scott Serafin on 10/1/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "MCItem.h"

@implementation MCItem

@synthesize itemName;           // Stone
@synthesize itemID;             // 1
@synthesize itemDescription;    // Stone is the most common resource...
@synthesize itemImage;          // stone.png


-(id) initWithitemName:(NSString *)theitemName itemID:(NSString *)theitemID itemDescription:(NSString *)theitemDescription itemImage:(NSString *)theitemImage
{
    if(self = [super init])
    {
        self.itemName = theitemName;
        self.itemID = theitemID;
        self.itemDescription = theitemDescription;
        self.itemImage = theitemImage;
    }
    return self;
}

@end

