//
//  GameScene.h
//  Twist
//
//  Created by Stephen Feuerstein on 10/4/12.
//  Copyright 2012 GingerSnAPPs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLevelLayer.h"
#import "ControlLayer.h"

@interface GameScene : CCScene
{
    GameLevelLayer *gameLevelLayer;
    ControlLayer *controlLayer;
}

+(id)sceneWithLevel:(NSUInteger)levelNum;
-(id)initWithLevelMap:(NSUInteger)levelNum;

@end
