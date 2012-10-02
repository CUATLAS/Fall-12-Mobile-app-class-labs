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

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]))
    {
        //CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Tilemap
        map = [[CCTMXTiledMap alloc] initWithTMXFile:@"level1.tmx"]; // newLevel.tmx
        [self addChild:map];
        
        walls = [map layerNamed:@"walls"];
        gravFlipWalls = [map layerNamed:@"gravTiles"];
        
        // Player
        player = [[Player alloc] init];
        player.position = [self getSpawnPointPosition];
        [map addChild:player z:15];
        
        // #### Load Game Data ####
        gameData = [GameData sharedGameData];
        // TODO: CHECK FOR PLAYCOUNT OF 0, and SET DEFAULTS
        gameData.rightButtonPressed = NO;
        gameData.leftButtonPressed = NO;
        gameData.jumpButtonPressed = NO;
        gameData.twistButtonPressed = NO;
        gameData.canFlipGravity = NO;
        // #### End Loading ####
        
        // Update per tick
        [self schedule:@selector(update:)];
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
                        p.onGround = YES;
                }
                // Tile above player
                else if (tileIndex == 1)
                {
                    p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y - intersection.size.height);
                    p.velocity = ccp(p.velocity.x, 0.0);
                    
                    // If Gravity is inverted
                    if (gameData.twistButtonPressed)
                        p.onGround = YES;
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
}

-(void)unloadTileMap
// Unloads the currently used tile map
{
    [self removeChild:map cleanup:YES];
    
    [map release];
    map = nil;
    [walls release];
    walls = nil;
}

-(void)loadLevel:(int)level
// Loads the tile map associated with the level number
{
    NSString *mapName = [NSString stringWithFormat:@"%@%d.tmx", MAPNAMEPREFIX, level];
    map = [[CCTMXTiledMap alloc] initWithTMXFile:mapName];
    
    [mapName release];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    map = nil;
    walls = nil;
    gravFlipWalls = nil;
    player = nil;
    gameData = nil;
    
    [map release];
    [walls release];
    [gravFlipWalls release];
    [player release];
    [gameData release];
	[super dealloc];
}
@end
