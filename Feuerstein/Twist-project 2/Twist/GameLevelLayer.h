//
//  GameLevelLayer.h
//  Twist
//
//  Created by Stephen Feuerstein on 7/31/12.
//  Copyright GingerSnAPPS 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Player.h"
#import "HUDLayer.h"
#import "ControlLayer.h"
#import "GameData.h"

@interface GameLevelLayer : CCLayer
{
    GameData *gameData;
    
    CCTMXTiledMap *map;
    CCTMXLayer *walls;
    CCTMXLayer *gravFlipWalls;
    CCTMXLayer *lavaPools;
    CCTMXLayer *exitTiles;
    CCTMXLayer *switches;
    
    Player *player;
    
    int currentLevel;
    int eventNum; // For death/success events
    
    // Original positions of environment effects
    CGPoint originalTeleportPos;
    
    CGPoint mapOffset;
    CGPoint originalMapPos;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)loadLevel:(NSUInteger)level;

@end
