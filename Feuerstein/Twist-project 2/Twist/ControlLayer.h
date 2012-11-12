//
//  ControlLayer.h
//  Twist
//
//  Created by Stephen Feuerstein on 8/20/12.
//  Copyright 2012 GingerSnAPPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"

@interface ControlLayer : CCLayer {
    GameData *gameData;
    
    CCSprite *leftArrowButton;
    CCSprite *rightArrowButton;
    CCSprite *jumpButton;
    CCSprite *twistButton;
    
    BOOL upArrowShowing;
    BOOL inGravArea;
}

@property (nonatomic, assign)BOOL rightTapped;
@property (nonatomic, assign)BOOL leftTapped;
@property (nonatomic, assign)BOOL jumpTapped;
@property (nonatomic, assign)BOOL twistTapped;

-(void)update:(ccTime)dt;

@end
