//
//  GameData.m
//  Twist
//
//  Created by Stephen Feuerstein on 8/20/12.
//  Copyright (c) 2012 GingerSnAPPS. All rights reserved.
//

#import "GameData.h"

static GameData *sharedGameData_ = nil;

@implementation GameData

@synthesize playCount;
@synthesize rightButtonPressed, leftButtonPressed, jumpButtonPressed;
@synthesize canFlipGravity;
@synthesize twistButtonPressed;
@synthesize gravityRotation;
@synthesize currentLevel;
@synthesize levelsUnlocked;

+(GameData *)sharedGameData
{
    if (!sharedGameData_)
    {
        sharedGameData_ = [[GameData alloc] init];
    }
    return sharedGameData_;
}

+(id)alloc
{
    NSAssert(sharedGameData_ == nil, @"Attempted to allocate a second instance of GameData singleton");
    return [super alloc];
}

+(void)purgeSharedGameData
// Clears all data and sets to nil
{
    [sharedGameData_ release];
    sharedGameData_ = nil;
}

-(id)init
{
    if ((self = [super init]))
    {
        [self loadSavedState];
    }
    return self;
}

-(void)loadSavedState
// Loads saved data from NSUserDefaults
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Play Count
    playCount = [prefs integerForKey:kGameDataPlayCount];
    
    // Movement Buttons
    rightButtonPressed = [prefs boolForKey:kGameDataRightButtonPressed];
    leftButtonPressed = [prefs boolForKey:kGameDataLeftButtonPressed];
    jumpButtonPressed = [prefs boolForKey:kGameDataJumpButtonPressed];
    
    // Gravity Rotation
    canFlipGravity = [prefs boolForKey:kGameDataCanFlipGravity];
    twistButtonPressed = [prefs boolForKey:kGameDataTwistButtonPressed];
    gravityRotation = [prefs integerForKey:kGameDataGravityRotation];
    
    // Level Information
    currentLevel = [prefs integerForKey:kGameDataCurrentLevel];
    levelsUnlocked = [prefs integerForKey:kGameDataLevelsUnlocked];
}

-(void)saveState
// Saves game data to NSUserDefaults
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Play Count
    [prefs setInteger:playCount forKey:kGameDataPlayCount];
    
    // Movement Buttons
    [prefs setBool:rightButtonPressed forKey:kGameDataRightButtonPressed];
    [prefs setBool:leftButtonPressed forKey:kGameDataLeftButtonPressed];
    [prefs setBool:jumpButtonPressed forKey:kGameDataJumpButtonPressed];
    
    // Gravity Rotation
    [prefs setBool:canFlipGravity forKey:kGameDataCanFlipGravity];
    [prefs setBool:twistButtonPressed forKey:kGameDataTwistButtonPressed];
    [prefs setInteger:gravityRotation forKey:kGameDataGravityRotation];
    
    // Level Information
    [prefs setInteger:currentLevel forKey:kGameDataCurrentLevel];
    [prefs setInteger:levelsUnlocked forKey:kGameDataLevelsUnlocked];
    
    [prefs synchronize];
}

-(void)dealloc
{
    sharedGameData_ = nil;
    [super dealloc];
}

@end
