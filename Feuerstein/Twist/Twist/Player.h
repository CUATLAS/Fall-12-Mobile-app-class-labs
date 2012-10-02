//
//  Player.h
//  Twist
//
//  Created by Stephen Feuerstein on 8/6/12.
//  Copyright 2012 GingerSnAPPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite {
    BOOL facingRight;
    BOOL isRunning;
    BOOL glowIncreasing;
    BOOL displayingDust;
}

@property (nonatomic, assign)CGPoint velocity;
@property (nonatomic, assign)CGPoint desiredPosition;
@property (nonatomic, assign)BOOL onGround;
@property (nonatomic, assign)BOOL moveRight;
@property (nonatomic, assign)BOOL moveLeft;
@property (nonatomic, retain)CCAction *runAction; // Sprite running animation action
@property (nonatomic, assign)BOOL jump;
@property (nonatomic, assign)BOOL isRed;
@property (nonatomic, assign)BOOL displayingArrows;
@property (nonatomic, assign)BOOL previousGravityRegular; // BOOL for if previous grav state was regular (down)
@property (nonatomic, assign)BOOL canFlipGravity; // BOOL for if you can flip gravity, and will enable glow
@property (nonatomic, assign)BOOL isGlowing;

-(void)update:(ccTime)dt;
-(CGRect)collisionBoundingBox;

@end
