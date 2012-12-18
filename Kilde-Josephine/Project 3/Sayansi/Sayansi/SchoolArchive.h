//
//  SchoolArchive.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/17/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolArchive : NSObject <NSCoding, NSCopying>

@property(copy, nonatomic)NSString *nameTextField;
@property(copy, nonatomic)NSString *streetTextField;
@property(copy, nonatomic)NSString *cityTextField;
@property(copy, nonatomic)NSString *countryTextField;

@end
