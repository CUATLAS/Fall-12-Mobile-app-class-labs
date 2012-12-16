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
    CCSprite *pauseButton;
    
    CGRect pauseButtonRect;
    
    BOOL upArrowShowing;
    BOOL inGravArea;
    BOOL delayingSwitchPress;
    BOOL switchButtonDisplayed;
    BOOL currentSwitchIsOn;
    BOOL didTapPause;
    
    // Time label
    CCLabelTTF *timeLabel;
}

@property (nonatomic, assign)BOOL rightTapped;
@property (nonatomic, assign)BOOL leftTapped;
@property (nonatomic, assign)BOOL jumpTapped;
@property (nonatomic, assign)BOOL twistTapped;
@property (nonatomic, assign)BOOL onASwitch;
@property (nonatomic, assign)BOOL switchTapped;
@property (nonatomic, retain)CCLabelTTF *timeLabel;
@property (nonatomic, assign)CCLabelTTF *levelLabel;

-(void)update:(ccTime)dt;
-(void)setSwitchButtonWithBool:(BOOL)switchIsOnBool;
-(BOOL)pauseButtonTapped;

@end
