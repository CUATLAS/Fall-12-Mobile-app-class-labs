//
//  GameLevelLayer.m
//  Twist
//
//  Created by Stephen Feuerstein on 7/31/12.
//  Copyright GingerSnAPPS 2012. All rights reserved.
//


// Import the interfaces
#import "GameLevelLayer.h"
#import "Constants.h"
#import "GameScene.h"
#import "MainMenuScene.h"
#import "SimpleAudioEngine.h"

@implementation GameLevelLayer
@synthesize isPaused;
@synthesize endLevelDisplayed;
@synthesize tutString;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLevelLayer *layer = [GameLevelLayer node];
    
    ControlLayer *controls = [ControlLayer node];    
	
	// add layer as a child to scene
	[scene addChild: layer z:1 tag:1];
    [scene addChild:controls z:3 tag:3];
	
	// return the scene
	return scene;
}

-(CGPoint)getSpawnPointPosition
// Returns the position of the spawnPoint object in the tmxmap
// If no spawnpoint exists, this is reported out and the point (0,0) is returned
{    
    NSMutableDictionary *spawnPoint = [[map objectGroupNamed:@"spawnPoint"] objectNamed:@"spawnPoint1"];
    if (spawnPoint == nil)
        NSLog(@"spawnPoint object does not exist");
    else
    {
        return ccp([[spawnPoint valueForKey:@"x"] intValue], [[spawnPoint valueForKey:@"y"] intValue]);
    }
    return ccp(0,0);
}

-(CGPoint)tutorialPointPosition
// Returns the position of the tutorialPoint
{
    NSMutableDictionary *tutorialPoint = [[map objectGroupNamed:@"tutorial"] objectNamed:@"tut"];
    if (tutorialPoint == nil)
    {
        //NSLog(@"No tutorial point for level %d", currentLevel);
        return ccp(-1000, -1000);
    }
    else
    {
        return ccp([[tutorialPoint valueForKey:@"x"] intValue], [[tutorialPoint valueForKey:@"y"] intValue]);
    }
    return ccp(-1000,-1000);
}

-(ControlLayer *)getControlLayer
{
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    //[scene removeChildByTag:3 cleanup:YES];
    CCNode *controlLayer = [scene getChildByTag:3];
    
    return (ControlLayer *)controlLayer;
}

-(id) initWithLevel:(NSUInteger)level
{
	if( (self=[super init]))
    {
        isPaused = NO;
        endLevelDisplayed = NO;
        tutString = [NSString stringWithFormat:@""];
        
        // Start time at 0
        ControlLayer *controlLayer = [self getControlLayer];
        totalTime = 0;
        minutes = 0;
        seconds = 0;
        NSString *timeString = [NSString stringWithFormat:@"%d:%0.2f", minutes, seconds];
        [controlLayer.timeLabel setString:timeString];
        NSString *levelNumString = [NSString stringWithFormat:@"Level: %d", level];
        [controlLayer.levelLabel setString:levelNumString];
        
        // Tilemap
        //map = [[CCTMXTiledMap alloc] initWithTMXFile:@"level1.tmx"]; // newLevel.tmx
        [self addChild:map];
        
        // Check for level number, and display help if it is a low enough number?
        NSLog(@"Loading level %d...", level);
        
        walls = [map layerNamed:@"walls"];
        gravFlipWalls = [map layerNamed:@"gravTiles"];
        lavaPools = [map layerNamed:@"acid"];
        exitTiles = [map layerNamed:@"exit"];
        switches = [map layerNamed:@"switches"];
        spikes = [map layerNamed:@"spikes"];
        
        // Player
        player = [[Player alloc] init];
        player.position = [self getSpawnPointPosition];
        [map addChild:player z:3];
        
        // Sounds
        gravAreaSound = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:@"inGravArea.wav"] retain];
        
        // #### Load Game Data ####
        gameData = [GameData sharedGameData];
        gameData.rightButtonPressed = NO;
        gameData.leftButtonPressed = NO;
        gameData.jumpButtonPressed = NO;
        gameData.twistButtonPressed = NO;
        gameData.canFlipGravity = NO;
        currentLevel = level; // Set the current level
        // #### End Loading ####
        
        // Get star time for the level
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *starPlistPath = [bundle pathForResource:@"starTimes" ofType:@"plist"];
        NSDictionary *starTimeDict = [[NSDictionary alloc] initWithContentsOfFile:starPlistPath];
        starTime = [[starTimeDict objectForKey:[NSString stringWithFormat:@"%d",currentLevel]] floatValue];
        //NSLog(@"StarTime For level %d = %.01f", currentLevel, starTime);
        
        // Add teleporter effects
        if (teleporterActive)
            [self displayTeleporterEffects];
        
        // Update per tick
        [self schedule:@selector(update:)];
        
        originalMapPos = ccp(9999, 0);
        mapOffset = ccp(0,0);
        
        // Start music
        if ([GameData sharedGameData].soundMusicOn)
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"alienblues.wav" loop:YES];
	}
	return self;
}

-(CGPoint)tileCoordsForPosition:(CGPoint)position
// Returns the tile coordinates for a given position
{
    float x = floor(position.x / map.tileSize.width);
    float levelHeightInPixels = map.mapSize.height * map.tileSize.height;
    float y = floor((levelHeightInPixels - position.y) / map.tileSize.height);
    return ccp(x, y);
}

-(CGRect)tileRectFromTileCoords:(CGPoint)tileCoords
// Returns the tile's rectangle for given coordinates
{
    float levelHeightInPixels = map.mapSize.height * map.tileSize.height;
    CGPoint origin = ccp(tileCoords.x * map.tileSize.width,
                         levelHeightInPixels - ((tileCoords.y + 1) * map.tileSize.height));
    return CGRectMake(origin.x, origin.y, map.tileSize.width, map.tileSize.height);
}

-(NSArray *)getSurroundingTilesAtPosition:(CGPoint)position forLayer:(CCTMXLayer *)layer
// This method collects data for the 8 tiles surrounding the player at the give position.
// Data includes GIDs, coordinates, and origins of each tile.
{
    CGPoint playerPosition = [self tileCoordsForPosition:position];
    
    NSMutableArray *gids = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++)
    {
        int c = i % 3;          // column
        int r = (int)(i / 3);   // row
        CGPoint tilePosition = ccp(playerPosition.x + (c - 1), playerPosition.y + (r - 1));
        
        int tgid = [layer tileGIDAt:tilePosition];
        
        CGRect tileRect = [self tileRectFromTileCoords:tilePosition];
        
        NSDictionary *tileDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:tgid], @"gid",
                                  [NSNumber numberWithFloat:tileRect.origin.x], @"x",
                                  [NSNumber numberWithFloat:tileRect.origin.y], @"y",
                                  [NSValue valueWithCGPoint:tilePosition],@"tilePos",
                                  nil];
        [gids addObject:tileDict];
    }
    
    // Remove the player's tile from collision check array
    [gids removeObjectAtIndex:4];
    
    // Rearrange array to check tiles in this order:
    // bottom, top, left, right, top left, top right, bottom left, bottom right
    [gids insertObject:[gids objectAtIndex:2] atIndex:6];
    [gids removeObjectAtIndex:2];
    [gids exchangeObjectAtIndex:4 withObjectAtIndex:6];
    [gids exchangeObjectAtIndex:0 withObjectAtIndex:4];
    
    return (NSArray *)gids;
}

-(NSArray *)getAllNineTilesAtPosition:(CGPoint)position forLayer:(CCTMXLayer *)layer
// This method collects data for the 8 tiles surrounding the player at the give position
// as well as the tile that is centered on the player's position.
// Data includes GIDs, coordinates, and origins of each tile.
// USE THIS FOR GETTING GRAVITY AND COLOR CHANGE TILES
{
    CGPoint playerPosition = [self tileCoordsForPosition:position];
    
    NSMutableArray *gids = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++)
    {
        int c = i % 3;          // column
        int r = (int)(i / 3);   // row
        CGPoint tilePosition = ccp(playerPosition.x + (c - 1), playerPosition.y + (r - 1));
        
        int tgid = [layer tileGIDAt:tilePosition];
        
        CGRect tileRect = [self tileRectFromTileCoords:tilePosition];
        
        NSDictionary *tileDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:tgid], @"gid",
                                  [NSNumber numberWithFloat:tileRect.origin.x], @"x",
                                  [NSNumber numberWithFloat:tileRect.origin.y], @"y",
                                  [NSValue valueWithCGPoint:tilePosition],@"tilePos",
                                  nil];
        [gids addObject:tileDict];
    }
    
    return (NSArray *)gids;
}

-(NSArray *)getAllTilesForLayer:(CCTMXLayer *)layer
{
    NSMutableArray *gids = [NSMutableArray array];
    
    for (int xIndex = 0; xIndex < layer.layerSize.width; xIndex++)
    {
        for (int yIndex = 0; yIndex < layer.layerSize.height; yIndex++)
        {
            CGPoint tileCoords = ccp(xIndex, yIndex);
            
            CCSprite *tileSprite = [layer tileAt:tileCoords];
            if (tileSprite != nil)
            {
                int tGID = [layer tileGIDAt:tileCoords];
                CGRect tileRect = [self tileRectFromTileCoords:tileCoords];
                
                NSDictionary *tileDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithInt:tGID], @"gid",
                                          [NSNumber numberWithFloat:tileRect.origin.x], @"x",
                                          [NSNumber numberWithFloat:tileRect.origin.y], @"y",
                                          [NSValue valueWithCGPoint:tileCoords],@"tilePos",
                                          nil];
                
                [gids addObject:tileDict];
            }
        }
    }
    
    return (NSArray *)gids;
}

-(void)updatePositionForParticleGenerator:(CCParticleSystemQuad *)particleGenerator
// This method updates the position for a particle system
// by adding the mapOffset values to its current position
{
    particleGenerator.position = ccpSub(originalTeleportPos, mapOffset);
}

-(void)displayTeleporterEffects
// This method displays particle effects at the level exit teleporter tiles
// This should only use the center tile for adding effects
{
    NSArray *exitTileArray = [self getAllTilesForLayer:exitTiles];
    
    NSDictionary *dict = [exitTileArray objectAtIndex:0];
    CGRect tileRect = CGRectMake([[dict objectForKey:@"x"] floatValue],
                                 [[dict objectForKey:@"y"] floatValue],
                                 map.tileSize.width, map.tileSize.height);
    CGPoint pos = ccp(tileRect.origin.x + map.tileSize.width/2, tileRect.origin.y - map.tileSize.height/3.5);
    
    CCParticleSystemQuad *teleporterParticles = [CCParticleSystemQuad particleWithFile:@"teleporterParticles.plist"];
    teleporterParticles.tag = TELEPORTERPARTICLESTAG;
    teleporterParticles.position = pos;
    
    // Set positionType so that particles move with the generator instead of staying on their own trail
    teleporterParticles.positionType = kCCPositionTypeGrouped;
    
    // Set original position for moving with layer
    originalTeleportPos = pos;

    [map addChild:teleporterParticles z:0];
}

-(void)removeBoxForTutPopup:(id)sender
{
    isPaused = NO;
    [self removeChildByTag:TUTBOXTAG cleanup:YES];
    [self removeChildByTag:TUTMENUTAG cleanup:YES];
    [self removeChildByTag:TUTLABELTAG cleanup:YES];
    
    // Reschedule update method
    [self schedule:@selector(update:)];
}

-(void)showTextForTutBox
// Shows the text for the tutorial box, and the OK button
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *messageLabel;
    if (tutString != nil)
    {
        messageLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", tutString] fontName:@"CreativeBlockBB" fontSize:18];
        messageLabel.color = ccc3(255, 255, 255);
        messageLabel.position = ccp(winSize.width/2, winSize.height/1.75);
        messageLabel.tag = TUTLABELTAG;
        [self addChild:messageLabel z:6];
    }
    else
    {
        messageLabel = [CCLabelTTF labelWithString:@"Tutorial String Nil" fontName:@"CreativeBlockBB" fontSize:18];
        messageLabel.color = ccc3(255, 255, 255);
        messageLabel.position = ccp(winSize.width/2, winSize.height/1.75);
        messageLabel.tag = TUTLABELTAG;
        [self addChild:messageLabel z:6];
    }
    
    // Add menu
    CCMenuItemFont *resumeItem = [CCMenuItemFont itemWithString:@"OK" target:self selector:@selector(removeBoxForTutPopup:)];
    resumeItem.fontName = @"CreativeBlockBB";
    resumeItem.fontSize = 20;
    
    CCMenu *menu = [CCMenu menuWithItems:resumeItem, nil];
    menu.color = ccc3(255, 255, 255);
    menu.tag = TUTMENUTAG;
    [menu alignItemsVerticallyWithPadding:30.0f];
    menu.position = ccp(menu.position.x, menu.position.y - winSize.height/8);
    [self addChild:menu z:6];
    
}
-(void)showBoxForTutPopupWithMessage:(NSString *)message
// Animates the box in, then calls the method to show the text
{
    //tutString = message; // Set the tutorial string
    isPaused = YES;
    [self unschedule:@selector(update:)];
    [player stopAllActions];
    [player setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"playerRunning5.png"]];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *tutBox = [CCSprite spriteWithFile:@"EndLevelBox.png"];
    
    // Set color based on if death or success
    tutBox.color = ccc3(255, 255, 255);
    tutBox.tag = TUTBOXTAG;
    
    tutBox.position = ccp(winSize.width/2, winSize.height/2);
    tutBox.scaleX = 0.1;
    tutBox.scaleY = 0.01;
    [self addChild:tutBox z:5];
    
    id scaleXAction = [CCScaleTo actionWithDuration:0.15 scaleX:0.6 scaleY:0.01];
    id scaleYAction = [CCScaleTo actionWithDuration:0.25 scaleX:0.6 scaleY:0.6];
    
    // Display the  correct menu items/message with event
    id displayMessageAction = [CCCallFuncN actionWithTarget:self selector:@selector(showTextForTutBox)];
    
    id sequence = [CCSequence actions:scaleXAction, scaleYAction, displayMessageAction, nil];
    [tutBox runAction:sequence];
}

-(void)displayTutorialPopupForLevel:(int)level
{
    // Update gameData with tutorial already displayed
    [[gameData shouldDisplayPopupArray] replaceObjectAtIndex:currentLevel-1 withObject:[NSNumber numberWithBool:NO]];
    [gameData saveState];
    
    switch (level)
    {
            // Movement
            NSString *message;
        case 1:
            NSLog(@"Tutorial 1 popup");
            message = @"Use the LEFT/RIGHT arrows\n at the bottom left \n to move your character\n to the teleporter";
            tutString = message;
            [self showBoxForTutPopupWithMessage:message];
            break;
            // Jumping
        case 2:
            NSLog(@"Tutorial 2 popup");
            message = @"Use the UP arrow\n at the bottom right \n to make your character jump \n (Hold to jump higher)";
            tutString = message;
            [self showBoxForTutPopupWithMessage:message];
            break;
            // Grav Flip
        case 3:
            NSLog(@"Tutorial 3 popup");
            message = @"When you're on glowing tiles\n press the TWIST button\n (next to jump)\n to flip gravity upside down";
            tutString = message;
            [self showBoxForTutPopupWithMessage:message];
            break;
            // Lava
        case 5:
            NSLog(@"Tutorial 5 popup");
            message = @"Watch out for lava!\n If you fall in, you'll have to \nstart the level over";
            tutString = message;
            [self showBoxForTutPopupWithMessage:message];
            break;
            // Spikes
        case 10:
            NSLog(@"Tutorial 5 popup");
            message = @"Watch out for spikes!\n If you hit them, you'll have to \nstart the level over";
            tutString = message;
            [self showBoxForTutPopupWithMessage:message];
            break;
            // Switches
        case 15:
            NSLog(@"Tutorial 15 popup");
            message = @"When you are over a switch\n the TWIST button will change\n to flip the switch. Switches\n turn on/off the teleporter";
            tutString = message;
            [self showBoxForTutPopupWithMessage:message];
            break;
            
        default:
            break;
    }
}

-(void)mainMenu:(id)sender
// Returns to the main menu
{
    if ([GameData sharedGameData].soundEffectsOn)
        [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    //[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene node] withColor:ccWHITE]];
}

-(void)retryLevel:(id)sender
// Selector for retrying the level
{
    if ([GameData sharedGameData].soundEffectsOn)
        [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    //[self removeAllChildrenWithCleanup:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithLevel:currentLevel] withColor:ccWHITE]];
}

-(void)nextLevel:(id)sender
// Selector for going to next level
{
    if (currentLevel < NUMBEROFLEVELS)
    {
        NSLog(@"Going to level %d", currentLevel+1);
        
        if ([GameData sharedGameData].soundEffectsOn)
            [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithLevel:currentLevel+1] withColor:ccWHITE]];
    }
    else
    {
        NSLog(@"Already at last level");
    }
}

-(void)resumeFromPause
// Resume button tapped, controls move back into place and menu animates out
{
    isPaused = NO;
    if ([GameData sharedGameData].soundEffectsOn)
        [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    
    if ([GameData sharedGameData].soundMusicOn)
    {
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    }
    
    // Reschedule update method
    [self schedule:@selector(update:)];
    
    // Remove menu and menu box, and reset control layer position
    ControlLayer *controlLayer = [self getControlLayer];
    controlLayer.position = originalControlPos;
    [self removeChildByTag:ENDLEVELMENUTAG cleanup:YES];
    [self removeChildByTag:ENDLEVELMESSAGETAG cleanup:YES];
    [self removeChildByTag:PAUSEMESSAGETAG cleanup:YES];
    
    // Transition out the box, then remove
    CCSprite *endLevelBox = (CCSprite *)[self getChildByTag:ENDLEVELBOXTAG];
    id scaleXAction = [CCScaleTo actionWithDuration:0.15 scaleX:0.01 scaleY:0.01];
    id scaleYAction = [CCScaleTo actionWithDuration:0.25 scaleX:1 scaleY:0.01];
    id removeBoxAction = [CCCallFuncN actionWithTarget:self selector:@selector(removeEndBox)];
    id removeSequence = [CCSequence actions:scaleYAction, scaleXAction, removeBoxAction, nil];
    [endLevelBox runAction:removeSequence];
}

-(void)removeEndBox
// Removes the end level box and cleans up memory usage
{
    [self removeChildByTag:ENDLEVELBOXTAG cleanup:YES];
}

-(void)displayDeathMenu
// Adds the messages/menu after the player dies
{
    endLevelDisplayed = YES;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *message = [CCLabelTTF labelWithString:@"You have died." fontName:@"CreativeBlockBB" fontSize:36];
    message.color = ccc3(255, 255, 255);
    message.position = ccp(winSize.width/2, winSize.height/1.25);
    
    [self addChild:message z:6];

    // Funny, random death comment
    NSString *deathMessageString;
    int randomVal = arc4random() % 14;
    switch (randomVal) {
        case 0:
            deathMessageString = @"Bro, do you even lift?";
            break;
        case 1:
            deathMessageString = @"Seriously??";
            break;
        case 2:
            deathMessageString = @"Not sure if level is impossible or\n you're just really bad at this game";
            break;
        case 3:
            deathMessageString = @"Maybe if you curse again you'll\n make it past this level";
            break;
        case 4:
            deathMessageString = @"60% of the time\n that move works all the time";
            break;
        case 5:
            deathMessageString = @"Weak...";
            break;
        case 6:
            deathMessageString = @"Did you know that if you hold\n the jump button you'll jump higher?";
            break;
        case 7:
            deathMessageString = @"Try getting a running start\n to clear large gaps";
            break;
        case 8:
            deathMessageString = @"Was it the spikes?\n Yeah, I bet it was the spikes";
            break;
        case 9:
            deathMessageString = @"Well that was... awesome";
            break;
        case 10:
            deathMessageString = @"Do it again!";
            break;
        case 11:
            deathMessageString = @"Oh, umm... Sorry about that";
            break;
        case 12:
            deathMessageString = @"ಠ_ಠ";
            break;
        case 13:
            deathMessageString = @"How did you die?\n There aren't even enemies";
            break;
            
        default:
            deathMessageString = @"";
            break;
    }
    
    CCLabelTTF *deathMessage = [CCLabelTTF labelWithString:deathMessageString fontName:@"CreativeBlockBB" fontSize:24];
    deathMessage.color = ccc3(255, 255, 255);
    deathMessage.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:deathMessage z:6];
    
    // Menu
    CCMenuItemFont *retryItem = [CCMenuItemFont itemWithString:@"Retry" target:self selector:@selector(retryLevel:)];
    retryItem.fontName = @"CreativeBlockBB";
    retryItem.fontSize = 24;
    CCMenuItemFont *mainMenuItem = [CCMenuItemFont itemWithString:@"Main Menu" target:self selector:@selector(mainMenu:)];
    mainMenuItem.fontName = @"CreativeBlockBB";
    mainMenuItem.fontSize = 24;
    
    CCMenu *menu = [CCMenu menuWithItems:mainMenuItem, retryItem, nil];
    menu.color = ccc3(255, 255, 255);
    menu.tag = ENDLEVELMENUTAG;
    //[menu alignItemsVerticallyWithPadding:30.0f];
    [menu alignItemsHorizontallyWithPadding:35.0f];
    menu.position = ccp(menu.position.x, menu.position.y - winSize.height/3); // /8
    [self addChild:menu z:6];
}

-(void)displayLevelCompleteMenu
// Adds the messages/menu after the player completes the current level
{
    endLevelDisplayed = YES;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *message = [CCLabelTTF labelWithString:@"Congratulations!" fontName:@"CreativeBlockBB" fontSize:36];
    message.color = ccc3(255, 255, 255);
    message.position = ccp(winSize.width/2, winSize.height/1.25);
    
    [self addChild:message z:6];
    
    // Menu
    CCMenuItemFont *retryLevel = [CCMenuItemFont itemWithString:@"Retry Level" target:self selector:@selector(retryLevel:)];
    retryLevel.fontName = @"CreativeBlockBB";
    retryLevel.fontSize = 24;
    CCMenuItemFont *nextLevel = [CCMenuItemFont itemWithString:@"Next Level" target:self selector:@selector(nextLevel:)];
    nextLevel.fontName = @"CreativeBlockBB";
    nextLevel.fontSize = 24;
    CCMenuItemFont *mainMenuItem = [CCMenuItemFont itemWithString:@"Main Menu" target:self selector:@selector(mainMenu:)];
    mainMenuItem.fontName = @"CreativeBlockBB";
    mainMenuItem.fontSize = 24;
    
    // Star sprite
    CCSprite *starSprite = [CCSprite spriteWithFile:@"endLevelStar.png"];
    if (totalTime < starTime)
    {
        starSprite.position = ccp(winSize.width/2, winSize.height/1.5);
        starSprite.scale = 0.01;
        [self addChild:starSprite z:6];
        
        id scaleStarAction = [CCScaleTo actionWithDuration:0.4 scale:0.3];
        [starSprite runAction:scaleStarAction];
        
        if ([GameData sharedGameData].soundEffectsOn)
            [[SimpleAudioEngine sharedEngine] playEffect:@"star.wav"];
    }
    
    // Show correct menu for next level or last level
    CCMenu *menu;
    if (eventNum == 3)
    {
        menu = [CCMenu menuWithItems:retryLevel, mainMenuItem, nil];
        //[menu alignItemsVerticallyWithPadding:10];
        
        // Also add end of game message
        CCLabelTTF *endMessage = [CCLabelTTF labelWithString:@"You beat the last level!\n Check back soon for new levels" fontName:@"CreativeBlockBB" fontSize:20];
        endMessage.color = ccc3(255, 255, 255);
        
        // Set position of text based on star or not
        if (totalTime < starTime)
            endMessage.position = ccp(winSize.width/2, winSize.height/2);
        else
            endMessage.position = ccp(winSize.width/2, winSize.height/1.6);
        [self addChild:endMessage z:6];
    }
    else
    {
        menu = [CCMenu menuWithItems:mainMenuItem, retryLevel, nextLevel, nil];
        //[menu alignItemsVerticallyWithPadding:15];
        
    }
    
    menu.color = ccc3(255, 255, 255);
    menu.tag = ENDLEVELMENUTAG;
    [menu alignItemsHorizontallyWithPadding:35.0f];
    menu.position = ccp(menu.position.x, menu.position.y - winSize.height/3); // winsize/4
    [self addChild:menu z:6];
    
    // Update and save state
    // Increment levels unlocked and current level if current level == levels unlocked && there is another level
    if (currentLevel == [GameData sharedGameData].levelsUnlocked && currentLevel < NUMBEROFLEVELS)
    {
        gameData.levelsUnlocked++;
        [gameData saveState]; // Saves the game state
    }
    
    // Time labels
    int bestMin = [[gameData.timeForLevelsArray objectAtIndex:currentLevel-1] floatValue]/60;
    float bestSec = [[gameData.timeForLevelsArray objectAtIndex:currentLevel-1] floatValue] - (60 * bestMin);
    NSString *timeString;
    NSString *bestTimeString;
    
    if (bestMin > 0)
    {
        bestTimeString = [NSString stringWithFormat:@"Best: %dmin %.01fsec", bestMin, bestSec];
    }
    else
    {
        bestTimeString = [NSString stringWithFormat:@"Best: %.01fsec", bestSec];
    }
    
    if (minutes > 0)
        timeString = [NSString stringWithFormat:@"Time: %dmin %.01fsec", minutes, seconds];
    else
        timeString = [NSString stringWithFormat:@"Time: %.01fsec", seconds];
    
    CCLabelTTF *timeMessage = [CCLabelTTF labelWithString:timeString fontName:@"CreativeBlockBB" fontSize:22];
    timeMessage.color = ccc3(255, 255, 255);
    timeMessage.position = ccp(winSize.width/2, winSize.height/2); // /1.55
    CCLabelTTF *bestMessage = [CCLabelTTF labelWithString:bestTimeString fontName:@"CreativeBlockBB" fontSize:22];
    bestMessage.color = ccc3(255, 255, 255);
    bestMessage.position = ccp(winSize.width/2, timeMessage.position.y - bestMessage.contentSize.height*1.5);
    
    // Check for last level and star, and reposition labels
    if (eventNum == 3)
    {
        if (totalTime < starTime)
        {
            timeMessage.position = ccp(winSize.width/2, winSize.height/2.7);
            bestMessage.position = ccp(winSize.width/2, timeMessage.position.y - bestMessage.contentSize.height*1.2);
        }
        else
        {
            timeMessage.position = ccp(winSize.width/2, winSize.height/2.45);
            bestMessage.position = ccp(winSize.width/2, timeMessage.position.y - bestMessage.contentSize.height*1.5);
        }
    }
    
    [self addChild:timeMessage z:6];
    [self addChild:bestMessage z:6];
    
    // Display and save time
    //minutes = (int)(totalTime / 60);
    //seconds =  totalTime - (60 * minutes);
    //NSLog(@"Level Time: %dmin %.01fsec", minutes, seconds);
}

-(void)displayPauseMessage
// Adds the messages/menu after the player completes the current level
{
    isPaused = YES;
    
    // Pause background music
    if ([GameData sharedGameData].soundMusicOn)
    {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *message = [CCLabelTTF labelWithString:@"Paused" fontName:@"CreativeBlockBB" fontSize:36];
    message.color = ccc3(255, 255, 255);
    message.position = ccp(winSize.width/2, winSize.height/1.25);
    message.tag = ENDLEVELMESSAGETAG;
    
    [self addChild:message z:6];
    
    // Time and level message
    NSString *timeString;
    if (minutes > 0)
        timeString = [NSString stringWithFormat:@"Time: %dmin %.01fsec", minutes, seconds];
    else
        timeString = [NSString stringWithFormat:@"Time: %.01fsec", seconds];
    CCLabelTTF *pauseMessage = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Level %d\n %@", currentLevel, timeString] fontName:@"CreativeBlockBB" fontSize:28];
    pauseMessage.color = ccc3(255, 255, 255);
    pauseMessage.position = ccp(winSize.width/2, winSize.height/2);
    pauseMessage.tag = PAUSEMESSAGETAG;
    [self addChild:pauseMessage z:6];
    
    // Menu
    CCMenuItemFont *retryItem = [CCMenuItemFont itemWithString:@"Retry" target:self selector:@selector(retryLevel:)];
    retryItem.fontName = @"CreativeBlockBB";
    retryItem.fontSize = 24;
    CCMenuItemFont *resumeItem = [CCMenuItemFont itemWithString:@"Resume" target:self selector:@selector(resumeFromPause)];
    resumeItem.fontName = @"CreativeBlockBB";
    resumeItem.fontSize = 24;
    CCMenuItemFont *mainMenuItem = [CCMenuItemFont itemWithString:@"Main Menu" target:self selector:@selector(mainMenu:)];
    mainMenuItem.fontName = @"CreativeBlockBB";
    mainMenuItem.fontSize = 24;
    
    CCMenu *menu = [CCMenu menuWithItems:mainMenuItem, retryItem, resumeItem, nil];
    menu.color = ccc3(255, 255, 255);
    menu.tag = ENDLEVELMENUTAG;
    //[menu alignItemsVerticallyWithPadding:30.0f];
    [menu alignItemsHorizontallyWithPadding:35.0f];
    menu.position = ccp(menu.position.x, menu.position.y - winSize.height/3); // winsize/8
    [self addChild:menu z:6];
    
}

-(void)displayEndLevelBox
// This method displays the box that animates into place at the end of a level
// and also after death. It will call the appropriate helper method
// to display either death options, or congratulations options
// eventNum == 0 if death, 1 if successfully completed level, 2 if paused, 3 if last level
{
    // Update and save state
    [gameData saveState];
    
    // Stop schedulers
    [self unschedule:@selector(update:)];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // End level box
    CCSprite *endLevelBox = [CCSprite spriteWithFile:@"EndLevelBox.png"];
    
    // Set color based on if death or success
    endLevelBox.color = ccc3(255, 100, 0);
    endLevelBox.tag = ENDLEVELBOXTAG;
    
    endLevelBox.position = ccp(winSize.width/2, winSize.height/2);
    endLevelBox.scaleX = 0.1;
    endLevelBox.scaleY = 0.01;
    [self addChild:endLevelBox z:5];
    
    id scaleXAction = [CCScaleTo actionWithDuration:0.15 scaleX:1 scaleY:0.01];
    id scaleYAction = [CCScaleTo actionWithDuration:0.25 scaleX:1 scaleY:1];
    
    // Display the  correct menu items/message with event
    id displayMessageAction;
    // Player Died
    if (eventNum == 0)
    {
        displayMessageAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayDeathMenu)];
        endLevelBox.color = ccc3(255, 100, 0);
    }
    // Player completed level
    else if (eventNum == 1)
    {
        displayMessageAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayLevelCompleteMenu)];
        endLevelBox.color = ccc3(0, 50, 255);
    }
    // Last Level
    else if (eventNum == 3)
    {
        // ADD LAST LEVEL METHOD
        displayMessageAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayLevelCompleteMenu)];
        endLevelBox.color = ccc3(0, 50, 255);
    }
    // Paused
    else
    {
        displayMessageAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayPauseMessage)];
        endLevelBox.color = ccc3(255, 255, 255);
    }
    
    id scaleAndDisplayMessageSequence = [CCSequence actions:scaleXAction, scaleYAction, displayMessageAction, nil];
    [endLevelBox runAction:scaleAndDisplayMessageSequence];
}

-(void)displayPauseMenu
// Adds the pause menu with main menu, retry, and resume options
{
    ControlLayer *controlLayer = [self getControlLayer];
    originalControlPos = controlLayer.position; // Save old position for moving control menu back
    controlLayer.position = ccp(0, -400);
    eventNum = 2;
    [self displayEndLevelBox];

    //[self unschedule:@selector(update:)];
}

-(void)playerDied:(Player *)p onHazardType:(NSString *)hazardType
// This method is called when the player collides with a hazard tile.
// It will perform an animation for the player dying based on what type
// of tile caused the death, unschedule all currently running selectors,
// then pop up a retry menu.
{
    NSLog(@"player died");
    [self unscheduleAllSelectors];
    if ([[[CCDirector sharedDirector] runningScene] getChildByTag:3] != nil)
    {
        ControlLayer *controlLayer = [self getControlLayer];
        controlLayer.position = ccp(0, -400);
    }

    // Animate death
    [p animateDeathForHazardType:hazardType];
    
    id delayAction = [CCDelayTime actionWithDuration:(p.animationTime + 0.1)]; // time delay adjusted to be animation time of player
    id showEndLevelAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayEndLevelBox)];
    id sequence = [CCSequence actionOne:delayAction two:showEndLevelAction];
    [self runAction:sequence];
}

-(void)playerFinishedLevel:(Player *)p
// Player finished the level, calls all actions to signify and bring up menu
{
    [self unscheduleAllSelectors];
    
    // Check for star collected, and update accordingly
    //if (![[gameData.starsCollectedArray objectAtIndex:currentLevel-1] boolValue] && currentLevel < 4) // CHANGE TO TIME
    if (![[gameData.starsCollectedArray objectAtIndex:currentLevel-1] boolValue] && totalTime < starTime)
    {
        NSLog(@"Setting %d star to YES", currentLevel);
        [gameData.starsCollectedArray replaceObjectAtIndex:currentLevel-1 withObject:[NSNumber numberWithBool:YES]];
    }
    
    // Check for best time, and update accordingly
    if ([[gameData.timeForLevelsArray objectAtIndex:currentLevel-1] floatValue] < 0.1 ||
        (totalTime < [[gameData.timeForLevelsArray objectAtIndex:currentLevel-1] floatValue]))
    {
        [gameData.timeForLevelsArray replaceObjectAtIndex:currentLevel-1 withObject:[NSNumber numberWithFloat:totalTime]];
    }
    //NSLog(@"totalTime: %.01f", totalTime);
    //NSLog(@"best time: %.01f", [[gameData.timeForLevelsArray objectAtIndex:currentLevel-1] floatValue]);
    
    if ([[[CCDirector sharedDirector] runningScene] getChildByTag:3] != nil)
    {
        ControlLayer *controlLayer = [self getControlLayer];
        controlLayer.position = ccp(0, -400);
    }

    // Animate level exit
    [p animateLevelExit];
    
    id delayAction = [CCDelayTime actionWithDuration:(p.animationTime + 0.1)]; // time delay adjusted to be animation time of player
    id showEndLevelAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayEndLevelBox)];
    id sequence = [CCSequence actionOne:delayAction two:showEndLevelAction];
    [self runAction:sequence];
}

-(void)checkForAndResolveCollisions:(Player *)p
{
    NSArray *tiles = [self getSurroundingTilesAtPosition:p.position forLayer:walls];
    //NSArray *gravTiles = [self getSurroundingTilesAtPosition:p.position forLayer:gravFlipWalls];
    NSArray *gravTiles = [self getAllNineTilesAtPosition:p.position forLayer:gravFlipWalls];
    
    p.onGround = NO;
    
    // ###### START REGULAR TILES ######
    for (NSDictionary *dict in tiles)
    {
        CGRect pRect = [p collisionBoundingBox];
        
        int gid = [[dict objectForKey:@"gid"] intValue]; // returns 0 if tile doesn't exist
        
        if (gid)
        {
            CGRect tileRect = CGRectMake([[dict objectForKey:@"x"] floatValue],
                                         [[dict objectForKey:@"y"] floatValue],
                                         map.tileSize.width, map.tileSize.height);
            // If collision between player and tile
            if (CGRectIntersectsRect(pRect, tileRect))
            {
                CGRect intersection = CGRectIntersection(pRect, tileRect);
                
                int tileIndex = [tiles indexOfObject:dict];
                
                // Tile below player
                if (tileIndex == 0)
                {
                    p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y + intersection.size.height);
                    p.velocity = ccp(p.velocity.x, 0.0);
                    
                    if (!gameData.twistButtonPressed)
                    {
                        p.onGround = YES;
                    }
                }
                // Tile above player
                else if (tileIndex == 1)
                {
                    p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y - intersection.size.height);
                    p.velocity = ccp(p.velocity.x, 0.0);
                    
                    // If Gravity is inverted
                    if (gameData.twistButtonPressed)
                    {
                        p.onGround = YES;
                        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
                    }
                }
                // Tile left of player
                else if (tileIndex == 2)
                {
                    p.desiredPosition = ccp(p.desiredPosition.x + intersection.size.width, p.desiredPosition.y);
                }
                // Tile right of player
                else if (tileIndex == 3)
                {
                    p.desiredPosition = ccp(p.desiredPosition.x - intersection.size.width, p.desiredPosition.y);
                }
                // Diagonal
                else
                {
                    // resolve vertically
                    if (intersection.size.width > intersection.size.height)
                    {
                        p.velocity = ccp(p.velocity.x, 0.0);
                        
                        float intersectionHeight;
                        if (tileIndex > 5)
                        {
                            intersectionHeight = intersection.size.height;
                            p.onGround = YES;
                        }
                        else
                            intersectionHeight = -intersection.size.height;
                        
                        p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y + intersection.size.height);
                    }
                    // resolve horizontally
                    else
                    {
                        float intersectionWidth;
                        if (tileIndex == 6 || tileIndex == 4)
                            intersectionWidth = intersection.size.width;
                        else
                            intersectionWidth = -intersection.size.width;
                        
                        p.desiredPosition = ccp(p.desiredPosition.x + intersectionWidth, p.desiredPosition.y);
                    }
                }
            }
        }
    }
    // ###### END REGULAR TILES ######
    
    // ###### START GRAVFLIP TILES ######
    BOOL inGravArea = NO;
    for (NSDictionary *dict in gravTiles)
    {
        CGRect pRect = [p collisionBoundingBox];
        
        int gid = [[dict objectForKey:@"gid"] intValue]; // returns 0 if tile doesn't exist
        
        if (gid)
        {
            CGRect tileRect = CGRectMake([[dict objectForKey:@"x"] floatValue],
                                         [[dict objectForKey:@"y"] floatValue],
                                         map.tileSize.width, map.tileSize.height);
            // If collision between player and tile
            if (CGRectIntersectsRect(pRect, tileRect))
            {
                inGravArea = YES;
                
                if ([GameData sharedGameData].soundEffectsOn && gravAreaSound != nil && ![gravAreaSound isPlaying])
                    [gravAreaSound play];
            }
        }
    }
    
    if (inGravArea)
    {
        gameData.canFlipGravity = YES;
        player.canFlipGravity = YES;
    }
    else
    {
        gameData.canFlipGravity = NO;
        player.canFlipGravity = NO;
    }
    // ###### END GRAVFLIP TILES ######
    
    // ###### START LAVA TILES ######
    NSArray *lavaTiles = [self getAllTilesForLayer:lavaPools];
    for (NSDictionary *dict in lavaTiles)
    {
        BOOL playerDidDie = NO;
        CGRect pRect = [p collisionBoundingBox];
        
        int gid = [[dict objectForKey:@"gid"] intValue]; // returns 0 if tile doesn't exist
        
        if (gid)
        {
            CGRect tileRect = CGRectMake([[dict objectForKey:@"x"] floatValue],
                                         [[dict objectForKey:@"y"] floatValue],
                                         map.tileSize.width, map.tileSize.height);
            // If collision between player and tile
            if (CGRectIntersectsRect(pRect, tileRect))
            {
                eventNum = 0;
                [self playerDied:p onHazardType:HAZARDTYPELAVA];
                playerDidDie = YES;
                
                // Stop background music
                if ([GameData sharedGameData].soundMusicOn)
                    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                // Play Sound
                if ([GameData sharedGameData].soundEffectsOn)
                    [[SimpleAudioEngine sharedEngine] playEffect:@"lavaburn.wav"];
            }
        }
        if (playerDidDie)
            return;
    }
    // ###### END LAVA TILES ######
    
    // ###### START SPIKE TILES ######
    NSArray *spikeTiles = [self getAllTilesForLayer:spikes];
    for (NSDictionary *dict in spikeTiles)
    {
        BOOL playerDidDie = NO;
        CGRect pRect = [p collisionBoundingBox];
        
        int gid = [[dict objectForKey:@"gid"] intValue]; // returns 0 if tile doesn't exist
        
        if (gid)
        {
            CGRect tileRect = CGRectMake([[dict objectForKey:@"x"] floatValue],
                                         [[dict objectForKey:@"y"] floatValue],
                                         map.tileSize.width, map.tileSize.height);
            // If collision between player and tile
            if (CGRectIntersectsRect(pRect, tileRect))
            {
                eventNum = 0;
                [self playerDied:p onHazardType:HAZARDTYPESPIKES];
                playerDidDie = YES;
                
                // Stop background music
                if ([GameData sharedGameData].soundMusicOn)
                    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                // Play sound
                if ([GameData sharedGameData].soundEffectsOn)
                    [[SimpleAudioEngine sharedEngine] playEffect:@"spikeHit.wav"];
            }
        }
        if (playerDidDie)
            return;
    }
    // ###### END SPIKE TILES ######
    
    // ###### START SWITCH TILES ######
    NSArray *switchTiles = [self getAllTilesForLayer:switches];
    for (NSDictionary *dict in switchTiles)
    {
        CGRect pRect = [p collisionBoundingBox];
        
        int gid = [[dict objectForKey:@"gid"] intValue]; // returns 0 if tile doesn't exist
        
        if (gid)
        {
            CGRect tileRect = CGRectMake([[dict objectForKey:@"x"] floatValue],
                                         [[dict objectForKey:@"y"] floatValue],
                                         map.tileSize.width, map.tileSize.height);
            // If collision between player and tile
            if (CGRectIntersectsRect(pRect, tileRect))
            {
                // Get the control layer
                ControlLayer *controlLayer = [self getControlLayer];
                controlLayer.onASwitch = YES;
                
                // MOVE THIS TO THE CONTROL LAYER
                if (controlLayer.switchTapped)
                {
                    BOOL switchIsOn = NO;
                    controlLayer.switchTapped = NO;
                    int tgid = [[dict objectForKey:@"gid"] intValue];
                    if (tgid == 8)
                    {
                        tgid++;
                        switchIsOn = YES;
                    }
                    else
                        tgid = 8;
                    
                    if (switchIsOn)
                    {
                        NSLog(@"Switch is On");
                        teleporterActive = YES;
                    }
                    else
                    {
                        NSLog(@"Switch is Off");
                        teleporterActive = NO;
                    }
                    [controlLayer setSwitchButtonWithBool:switchIsOn];
                    
                    // Turn on/off teleporter particles
                    CCParticleSystemQuad *teleporterParticles = (CCParticleSystemQuad *)[map getChildByTag:TELEPORTERPARTICLESTAG];
                    // If not initially on, add the particles
                    if (!teleporterParticles && switchIsOn)
                    {
                        [self displayTeleporterEffects];
                    }
                    else
                    {
                        if (!switchIsOn)
                        {
                            [teleporterParticles stopSystem];
                        }
                        else
                        {
                            [teleporterParticles resetSystem];
                        }
                    }
                    
                    CGPoint tilePos = ccp([[dict objectForKey:@"x"] floatValue],
                                          [[dict objectForKey:@"y"] floatValue]);
                    CGPoint tileCoords = [self tileCoordsForPosition:tilePos];
                    tileCoords = ccp(tileCoords.x, tileCoords.y - 1);
                    [switches removeTileAt:tileCoords];
                    [switches setTileGID:tgid at:tileCoords];
                }
                // MOVE ABOVE TO CONTROL LAYER
            }
            else
            {
                ControlLayer *controlLayer = [self getControlLayer];
                controlLayer.onASwitch = NO;
            }
        }
    }
    // ###### END SWITCH TILES ######
    
    // ###### TUTORIAL OBJECTS ######
    if ([[[gameData shouldDisplayPopupArray] objectAtIndex:currentLevel-1] boolValue]
        && CGRectContainsPoint([p collisionBoundingBox], [self tutorialPointPosition]))
    {
        [self displayTutorialPopupForLevel:currentLevel];
    }
    // ###### END TUTORIAL OBJECTS ######
    
    // ###### START EXIT TILES ######
    NSArray *exitTileArray = [self getAllTilesForLayer:exitTiles];
    if (exitTileArray)
    {
        for (NSDictionary *dict in exitTileArray)
        {
            CGRect pRect = [p collisionBoundingBox];
            
            int gid = [[dict objectForKey:@"gid"] intValue]; // returns 0 if tile doesn't exist
            
            if (gid)
            {
                CGRect tileRect = CGRectMake([[dict objectForKey:@"x"] floatValue],
                                             [[dict objectForKey:@"y"] floatValue],
                                             map.tileSize.width, map.tileSize.height);
                // If collision between player and tile
                if (CGRectIntersectsRect(pRect, tileRect))
                {
                    // Player must be in the middle 50% of the tile to teleport out
                    if ((p.position.x >= (tileRect.origin.x + (map.tileSize.width/4))
                         && p.position.x <= (tileRect.origin.x + 3*(map.tileSize.width/4)))
                        && teleporterActive)
                    {
                        if (currentLevel == NUMBEROFLEVELS)
                            eventNum = 3;
                        else
                            eventNum = 1;
                        // Set the player's x position to the center of the exit tile
                        p.position = ccp(tileRect.origin.x + (map.tileSize.width/2), p.position.y);
                        [self playerFinishedLevel:p];
                        
                        // Stop background music
                        if ([GameData sharedGameData].soundMusicOn)
                            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                    }
                }
            }
        }
    }
    else
        NSLog(@"Exit tiles not found!");
    // ###### END EXIT TILES ######
    
    p.position = p.desiredPosition;
}

-(void)checkForControlPresses
{
    // Move Right Check
    if (gameData.rightButtonPressed)
    {
        player.moveRight = YES;
    }
    else
        player.moveRight = NO;
    
    // Move Left Check
    if (gameData.leftButtonPressed)
    {
        player.moveLeft = YES;
    }
    else
        player.moveLeft = NO;
    
    // Jump Check
    if (gameData.jumpButtonPressed)
    {
        player.jump = YES;
    }
    else
        player.jump = NO;
}

-(void)setViewpointCenter:(CGPoint)position
// This function sets the viewpoint to be centered on the player,
// and moves the map around.
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    if (originalMapPos.x == 9999)
        originalMapPos = map.position;
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (map.mapSize.width * map.tileSize.width)
            - winSize.width / 2);
    y = MIN(y, (map.mapSize.height * map.tileSize.height)
            - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    map.position = viewPoint;
    
    mapOffset = ccpSub(originalMapPos, map.position);
}

-(void)update:(ccTime)dt
// Run per frame, call any necessary functions
{
    // Check for pause
    ControlLayer *controlLayer = [self getControlLayer];
    if ([controlLayer pauseButtonTapped])
        [self displayPauseMenu];
    
    // Update time label
    minutes = (int)(totalTime / 60);
    seconds =  totalTime - (60 * minutes);
    NSString *timeString = [NSString stringWithFormat:@"%d:%0.1f", minutes, seconds];
    [controlLayer.timeLabel setString:timeString];
    
    // Make sure the level string is updated correctly
    NSString *levelNumString = [NSString stringWithFormat:@"Level: %d", currentLevel];
    if (controlLayer.levelLabel.string != levelNumString)
    {
        [controlLayer.levelLabel setString:levelNumString];
    }
    
    // Increment time
    totalTime += dt;
    
    if (player.canFlipGravity)
        gameData.canFlipGravity = YES;
    
    [player update:dt];
    [self checkForAndResolveCollisions:player];
    [self checkForControlPresses];
    [self setViewpointCenter:player.position];
    
    // Generate environment effects
    // Teleporter Effects
    CCParticleSystemQuad *teleporterParticles = (CCParticleSystemQuad *)[self getChildByTag:TELEPORTERPARTICLESTAG];
    if (teleporterParticles)
    {
        //NSLog(@"Updating tele particle position");
        [self updatePositionForParticleGenerator:teleporterParticles];
    }
}

-(void)unloadTileMap
// Unloads the currently used tile map
{
    [self removeChild:map cleanup:YES];
    
    //[map release];
    map = nil;
    //[walls release];
    walls = nil;
}

-(void)loadLevel:(NSUInteger)level
// Unloads the current map, then loads the
// map given by level number, and initializes
// the map.
{
    if (map != nil)
        [self unloadTileMap];
    
    NSString *mapName = [NSString stringWithFormat:@"%@%d.tmx", MAPNAMEPREFIX, level];
    map = [[CCTMXTiledMap alloc] initWithTMXFile:mapName];
    
    // Set the teleporter to initially inactive except for on certain levels
    if ([[[[GameData sharedGameData] hasTeleSwitchArray] objectAtIndex:(level-1)] boolValue] == NO)
    {
        NSLog(@"Index active at: %d", (level-1));
        teleporterActive = YES;
    }
    else
    {
        NSLog (@"Teleporter inactive");
        teleporterActive = NO;
    }

    [self initWithLevel:level];
    
    //[mapName release];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    map = nil;
    walls = nil;
    gravFlipWalls = nil;
    player = nil;
    gameData = nil;

	[super dealloc];
}
@end
