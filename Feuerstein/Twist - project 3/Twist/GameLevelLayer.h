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
#import "CDAudioManager.h"

@interface GameLevelLayer : CCLayer
{
    GameData *gameData;
    
    CCTMXTiledMap *map;
    CCTMXLayer *walls;
    CCTMXLayer *gravFlipWalls;
    CCTMXLayer *lavaPools;
    CCTMXLayer *exitTiles;
    CCTMXLayer *switches;
    CCTMXLayer *spikes;
    
    Player *player;
    
    int currentLevel;
    int eventNum; // For death/success events
    NSString *tutString;
    
    // Original positions of environment effects
    CGPoint originalTeleportPos;
    CGPoint mapOffset;
    CGPoint originalMapPos;
    CGPoint originalControlPos;
    
    // Time tracking
    ccTime totalTime;
    int minutes;
    float seconds;
    float starTime;
    
    // Sounds
    CDSoundSource *gravAreaSound;
    
    BOOL teleporterActive;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)loadLevel:(NSUInteger)level;
-(void)displayPauseMenu;

@property (nonatomic, assign)BOOL isPaused;
@property (nonatomic, assign)BOOL endLevelDisplayed;
@property (nonatomic, retain)NSString *tutString;

@end
