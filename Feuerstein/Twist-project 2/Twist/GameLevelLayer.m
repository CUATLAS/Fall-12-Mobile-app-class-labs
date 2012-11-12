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

@implementation GameLevelLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLevelLayer *layer = [GameLevelLayer node];
    
    ControlLayer *controls = [ControlLayer node];    
    //HUDLayer *hud = [HUDLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer z:1 tag:1];
    [scene addChild:controls z:3 tag:3];
    //[scene addChild:hud z:2 tag:2];
	
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

-(id) initWithLevel:(NSUInteger)level
{
	if( (self=[super init]))
    {
        //CGSize winSize = [[CCDirector sharedDirector] winSize];
        
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
        
        // Player
        player = [[Player alloc] init];
        player.position = [self getSpawnPointPosition];
        [map addChild:player z:3];
        
        // #### Load Game Data ####
        gameData = [GameData sharedGameData];
        // TODO: CHECK FOR PLAYCOUNT OF 0, and SET DEFAULTS
        gameData.rightButtonPressed = NO;
        gameData.leftButtonPressed = NO;
        gameData.jumpButtonPressed = NO;
        gameData.twistButtonPressed = NO;
        gameData.canFlipGravity = NO;
        currentLevel = level; // Set the current level
        
        // levels
        gameData.levelsUnlocked = 2;
        // #### End Loading ####
        
        // Add teleporter effects
        [self displayTeleporterEffects];
        
        // Update per tick
        [self schedule:@selector(update:)];
        
        originalMapPos = ccp(9999, 0);
        mapOffset = ccp(0,0);
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
    NSLog(@"X: %f, Y: %f", particleGenerator.position.x, particleGenerator.position.y);
    
    //particleGenerator.position = ccp(100,100);
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

-(void)retryLevel:(id)sender
// Selector for retrying the level
{
    NSLog(@"Retrying level %d", currentLevel);
    //[self removeAllChildrenWithCleanup:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithLevel:currentLevel] withColor:ccWHITE]];
}

-(void)nextLevel:(id)sender
// Selector for going to next level
{
    if (currentLevel < NUMBEROFLEVELS)
    {
        NSLog(@"Going to level %d", currentLevel+1);
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithLevel:currentLevel+1] withColor:ccWHITE]];
    }
    else
    {
        NSLog(@"Already at last level");
    }
}

-(void)displayDeathMenu
// Adds the messages/menu after the player dies
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *message = [CCLabelTTF labelWithString:@"You have died." fontName:@"CreativeBlockBB" fontSize:30];
    message.color = ccc3(255, 255, 255);
    message.position = ccp(winSize.width/2, winSize.height/1.25);
    
    [self addChild:message z:6];
    
    // Menu
    CCMenuItemFont *retryItem = [CCMenuItemFont itemWithString:@"Retry" target:self selector:@selector(retryLevel:)];
    //retryItem.position = ccp(winSize.width/2, winSize.height/2);
    //retryItem.color = ccc3(255, 255, 255);
    CCMenu *menu = [CCMenu menuWithItems:retryItem, nil];
    menu.color = ccc3(255, 255, 255);
    [menu alignItemsVertically];
    [self addChild:menu z:6];
}

-(void)displayLevelCompleteMenu
// Adds the messages/menu after the player completes the current level
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *message = [CCLabelTTF labelWithString:@"Congratulations!" fontName:@"CreativeBlockBB" fontSize:30];
    message.color = ccc3(255, 255, 255);
    message.position = ccp(winSize.width/2, winSize.height/1.25);
    
    [self addChild:message z:6];
    
    // Menu
    CCMenuItemFont *nextLevel = [CCMenuItemFont itemWithString:@"Next Level" target:self selector:@selector(nextLevel:)];
    CCMenu *menu = [CCMenu menuWithItems:nextLevel, nil];
    menu.color = ccc3(255, 255, 255);
    [menu alignItemsVertically];
    [self addChild:menu z:6];
    
    // Update and save state
    // Increment levels unlocked and current level if current level == levels unlocked && there is another level
    if (currentLevel == [GameData sharedGameData].levelsUnlocked && currentLevel < NUMBEROFLEVELS)
    {
        gameData.levelsUnlocked++;
        [gameData saveState]; // Saves the game state
    }
}

-(void)displayEndLevelBox
// This method displays the box that animates into place at the end of a level
// and also after death. It will call the appropriate helper method
// to display either death options, or congratulations options
// eventNum == 0 if death, 1 if successfully completed level
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // End level box
    CCSprite *endLevelBox = [CCSprite spriteWithFile:@"EndLevelBox.png"];
    
    // Set color based on if death or success
    endLevelBox.color = ccc3(255, 100, 0);
    
    
    endLevelBox.position = ccp(winSize.width/2, winSize.height/2);
    endLevelBox.scaleX = 0.1;
    endLevelBox.scaleY = 0.01;
    [self addChild:endLevelBox z:5];
    
    id scaleXAction = [CCScaleTo actionWithDuration:0.3 scaleX:1 scaleY:0.01];
    id scaleYAction = [CCScaleTo actionWithDuration:0.3 scaleX:1 scaleY:1];
    
    // Display the  correct menu items/message with event
    id displayMessageAction;
    if (eventNum == 0)
    {
        displayMessageAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayDeathMenu)];
        endLevelBox.color = ccc3(255, 100, 0);
    }
    else
    {
        displayMessageAction = [CCCallFuncN actionWithTarget:self selector:@selector(displayLevelCompleteMenu)];
        endLevelBox.color = ccc3(0, 50, 255);
    }
    
    id scaleAndDisplayMessageSequence = [CCSequence actions:scaleXAction, scaleYAction, displayMessageAction, nil];
    [endLevelBox runAction:scaleAndDisplayMessageSequence];
}

-(void)playerDied:(Player *)p onHazardType:(NSString *)hazardType
// This method is called when the player collides with a hazard tile.
// It will perform an animation for the player dying based on what type
// of tile caused the death, unschedule all currently running selectors,
// then pop up a retry menu.
{
    NSLog(@"Player Has Died");
    
    [self unscheduleAllSelectors];
    if ([[[CCDirector sharedDirector] runningScene] getChildByTag:3] != nil)
    {
        //[[[CCDirector sharedDirector] runningScene] removeChildByTag:3 cleanup:YES];
        CCScene *scene = [[CCDirector sharedDirector] runningScene];
        //[scene removeChildByTag:3 cleanup:YES];
        CCNode *controlLayer = [scene getChildByTag:3];
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
    
    if ([[[CCDirector sharedDirector] runningScene] getChildByTag:3] != nil)
    {
        //[[[CCDirector sharedDirector] runningScene] removeChildByTag:3 cleanup:YES];
        CCScene *scene = [[CCDirector sharedDirector] runningScene];
        //[scene removeChildByTag:3 cleanup:YES];
        CCNode *controlLayer = [scene getChildByTag:3];
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
            }
        }
    }
    // ###### END LAVA TILES ######
    
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
                // MOVE THIS TO THE CONTROL LAYER
                int tgid = [[dict objectForKey:@"gid"] intValue];
                if (tgid == 8)
                    tgid++;
                
                CGPoint tilePos = ccp([[dict objectForKey:@"x"] floatValue],
                                         [[dict objectForKey:@"y"] floatValue]);
                CGPoint tileCoords = [self tileCoordsForPosition:tilePos];
                tileCoords = ccp(tileCoords.x, tileCoords.y - 1);
                [switches removeTileAt:tileCoords];
                [switches setTileGID:tgid at:tileCoords];
                // MOVE ABOVE TO CONTROL LAYER
            }
        }
    }
    // ###### END SWITCH TILES ######
    
    // ###### START EXIT TILES ######
    NSArray *exitTileArray = [self getAllTilesForLayer:exitTiles];
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
                if (p.position.x >= (tileRect.origin.x + (map.tileSize.width/4))
                    && p.position.x <= (tileRect.origin.x + 3*(map.tileSize.width/4)))
                {
                    eventNum = 1;
                    // Set the player's x position to the center of the exit tile
                    p.position = ccp(tileRect.origin.x + (map.tileSize.width/2), p.position.y);
                    [self playerFinishedLevel:p];
                }
            }
        }
    }
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
        [self updatePositionForParticleGenerator:teleporterParticles];
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
