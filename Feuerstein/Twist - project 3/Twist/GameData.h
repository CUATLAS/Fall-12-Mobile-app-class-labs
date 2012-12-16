//
//  GameData.h
//  Twist
//
//  Created by Stephen Feuerstein on 8/20/12.
//  Copyright (c) 2012 GingerSnAPPS. All rights reserved.
//
// GameData is a singleton class used for passing variables
// between classes, as well as saving options/game state
// when the app is closed, paused, etc. Achievements will
// also be taken care of in this class with BOOLs

#import <Foundation/Foundation.h>

// Play Count
#define kGameDataPlayCount @"GameDataPlayCount"

// Movement Buttons
#define kGameDataRightButtonPressed @"GameDataRightButtonPressed"
#define kGameDataLeftButtonPressed @"GameDataLeftButtonPressed"
#define kGameDataJumpButtonPressed @"GameDataJumpButtonPressed"

// Gravity Rotation
#define kGameDataCanFlipGravity @"GameDataCanFlipGravity"
#define kGameDataTwistButtonPressed @"GameDataTwistButtonPressed"
#define kGameDataGravityRotation @"GameDataGravityRotation"

// Level Information
#define kGameDataCurrentLevel @"GameDataCurrentLevel"
#define kGameDataLevelsUnlocked @"GameDataLevelsUnlocked"
#define kGameDataStarsCollectedArray @"GameDataStarsCollectedArray"
#define kGameDataTimeForLevelsArray @"GameDataTimeForLevelsArray"
#define kGameDataHasTeleSwitchArray @"GameDataHasTeleSwitchArray"

// Tutorial Popup Has Been Displayed
#define kGameDataShouldDisplayPopupArray @"GameDataShouldDisplayPopupArray"

// sounds
#define kGameDataSoundEffectsOn @"GameDataSoundEffectsOn"
#define kGameDataSoundMusicOn @"GameDataSoundMusicOn"

@interface GameData : NSObject
{
    // Play Count
    int playCount;
    
    // Movement Buttons
    BOOL rightButtonPressed;
    BOOL leftButtonPressed;
    BOOL jumpButtonPressed;
    
    // Gravity Rotation
    BOOL canFlipGravity;
    BOOL twistButtonPressed;
    int gravityRotation;
    
    // Level Information
    int currentLevel;
    int levelsUnlocked;
    NSMutableArray *starsCollectedArray;
    NSMutableArray *timeForLevelsArray;
    NSMutableArray *hasTeleSwitchArray;
    
    // Tutorial Popup
    NSMutableArray *shouldDisplayPopupArray;
    
    // Sounds
    BOOL soundEffectsOn;
    BOOL soundMusicOn;
}

-(void)loadSavedState;
-(void)saveState;
+(GameData *)sharedGameData;
+(void)purgeSharedGameData;

// Play Count
@property (nonatomic, assign) int playCount;

// Movement Buttons
@property (nonatomic, assign) BOOL rightButtonPressed;
@property (nonatomic, assign) BOOL leftButtonPressed;
@property (nonatomic, assign) BOOL jumpButtonPressed;

// Gravity Rotation
@property (nonatomic, assign) BOOL canFlipGravity;
@property (nonatomic, assign) BOOL twistButtonPressed;
@property (nonatomic, assign) int gravityRotation;

// Level Information
@property (nonatomic, assign) int currentLevel;
@property (nonatomic, assign) int levelsUnlocked;
@property (nonatomic, retain) NSMutableArray *starsCollectedArray;
@property (nonatomic, retain) NSMutableArray *timeForLevelsArray;
@property (nonatomic, retain) NSMutableArray *hasTeleSwitchArray;

// Tutorial Popup
@property (nonatomic, retain) NSMutableArray *shouldDisplayPopupArray;

// Sounds
@property (nonatomic, assign) BOOL soundEffectsOn;
@property (nonatomic, assign) BOOL soundMusicOn;

@end
