//
//  GameScene.m
//  Twist
//
//  Created by Stephen Feuerstein on 10/4/12.
//  Copyright 2012 GingerSnAPPs. All rights reserved.
//
// GameScene adds a GameLevelLayer based on the level number given to it.
// This can be used for selecting the correct level from a menu, and loading
// the tilemap dynamically based on user selection.

#import "GameScene.h"


@implementation GameScene

+(id)sceneWithLevel:(NSUInteger)levelNum
{
    return [[[self alloc] initWithLevelMap:levelNum] autorelease];
}

-(id)initWithLevelMap:(NSUInteger)levelNum
{
    gameLevelLayer = [GameLevelLayer node];
    [gameLevelLayer loadLevel:levelNum];
    
    controlLayer = [ControlLayer node];
    
    [self addChild:gameLevelLayer z:1 tag:1];
    [self addChild:controlLayer z:3 tag:3];
    
    return self;
}

@end
