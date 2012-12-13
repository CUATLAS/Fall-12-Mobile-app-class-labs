//
//  Task.h
//  Tasks
//
//  Created by Stephen Feuerstein on 11/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic, assign) BOOL complete;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *remoteId;

@end
