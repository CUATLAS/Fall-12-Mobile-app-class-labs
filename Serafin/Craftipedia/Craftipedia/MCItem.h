//
//  Attributes for items to be created in UI Table View
//  Craftipedia
//
//  Created by Scott Serafin on 10/1/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCItem : NSObject

@property (nonatomic, retain) NSString* itemName;           // Stone
@property (nonatomic, retain) NSString* itemID;             // 1
@property (nonatomic, retain) NSString* itemDescription;    // Stone is the most common resource...
@property (nonatomic, retain) NSString* itemImage;          // stone.png

-(id) initWithitemName:(NSString *)theitemName itemID:(NSString *)theitemID itemDescription:(NSString *)theitemDescription itemImage:(NSString *)theitemImage;

@end
