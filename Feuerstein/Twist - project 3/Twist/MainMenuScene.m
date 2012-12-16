//
//  MainMenuScene.m
//  Twist
//
//  Created by Stephen Feuerstein on 10/5/12.
//  Copyright 2012 GingerSnAPPs. All rights reserved.
//

#import "MainMenuScene.h"
#import "GameScene.h"
#import "MenuGridLayer.h"
#import "Constants.h"

@implementation MainMenuScene

-(id)init
{
    if ((self = [super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Teleporter background
        CCParticleSystemQuad *teleporterParticles = [CCParticleSystemQuad particleWithFile:@"teleporterParticles.plist"];
        //teleporterParticles.position = ccp(winSize.width/4 - 5, 2.75*winSize.height/4);
        teleporterParticles.position = ccp(winSize.width/4, -25);
        teleporterParticles.life = teleporterParticles.life + 5;
        teleporterParticles.speedVar = 25;
        teleporterParticles.posVar = ccp(winSize.width/2, 0);
        [self addChild:teleporterParticles z:1];
        CCParticleSystemQuad *teleporterParticles2 = [CCParticleSystemQuad particleWithFile:@"teleporterParticles.plist"];
        teleporterParticles2.position = ccp(3*winSize.width/4, -25);
        teleporterParticles2.life = teleporterParticles.life + 5;
        teleporterParticles2.speedVar = 25;
        teleporterParticles2.posVar = ccp(winSize.width/2, 0);
        [self addChild:teleporterParticles2 z:1];
        
        CCSprite *backgroundImage = [CCSprite spriteWithFile:@"background.png"];
        backgroundImage.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:backgroundImage];
        
        self.position = CGPointZero;
        self.anchorPoint = CGPointZero;
        
        // Initialize game data if playcount is 0
        GameData *gameData = [GameData sharedGameData];
        NSLog(@"gameData.playCount: %d", gameData.playCount);
        if (!gameData.playCount) // No plays yet
        {
            // Set all default values
            [GameData sharedGameData].levelsUnlocked = 1; // CHANGE TO 1
            [GameData sharedGameData].soundEffectsOn = YES;
            [GameData sharedGameData].soundMusicOn = YES;
            [GameData sharedGameData].starsCollectedArray = [NSMutableArray array];
            [GameData sharedGameData].timeForLevelsArray = [NSMutableArray array];
            [GameData sharedGameData].shouldDisplayPopupArray = [NSMutableArray array];
            [GameData sharedGameData].hasTeleSwitchArray = [NSMutableArray array];
            
            for (int i = 0; i < NUMBEROFLEVELS; i++)
            {
                [[GameData sharedGameData].starsCollectedArray addObject:[NSNumber numberWithBool:NO]];
                [[GameData sharedGameData].timeForLevelsArray addObject:[NSNumber numberWithFloat:0.0f]];
                [[GameData sharedGameData].shouldDisplayPopupArray addObject:[NSNumber numberWithBool:YES]];
                
                // Teleporter switch levels
                // CHANGE TO ACTUAL LEVELS WITH SWITCHES
                if (i > 13)
                {
                    [[GameData sharedGameData].hasTeleSwitchArray addObject:[NSNumber numberWithBool:YES]];
                    NSLog(@"Index %d set to YES", i);
                }
                else
                {
                    [[GameData sharedGameData].hasTeleSwitchArray addObject:[NSNumber numberWithBool:NO]];
                }
                
            }
        }
        gameData.playCount++;
        
        [[GameData sharedGameData] saveState];
        [self showMainMenuButtons];
    }
    return self;
}

-(void)showMainMenuButtons
// Displays the main menu items including play, options, etc.
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *menuItem1 = [CCMenuItemFont itemWithString:@"Play" target:self selector:@selector(playButton:)];
    menuItem1.fontName = @"CreativeBlockBB";
    menuItem1.fontSize = 30;
    menuItem1.position = ccp(winSize.width/8, winSize.height/4.5);
    // Background of label
    CCLabelTTF *playBG = [CCLabelTTF labelWithString:@"Play" fontName:@"CreativeBlockBB" fontSize:30];
    playBG.color = ccc3(0, 0, 0);
    playBG.position = ccp(menuItem1.position.x + 2, menuItem1.position.y + 2);
    playBG.tag = 995;
    [self addChild:playBG];
    
    CCMenu *menu = [CCMenu menuWithItems:menuItem1, nil];
    menu.position = CGPointZero;
    menu.color = ccc3(255, 255, 255);
    //[menu alignItemsVertically];
    [self addChild:menu z:1 tag:999];
    
    // Sound controls
    CCMenuItemFont *sfxMenuItem = [CCMenuItemFont itemWithString:@"SFX: ON" target:self selector:@selector(toggleSFX:)];
    sfxMenuItem.fontName = @"CreativeBlockBB";
    sfxMenuItem.fontSize = 30;
    sfxMenuItem.position = ccp(menuItem1.position.x, menuItem1.position.y - winSize.height/9);
    
    CCMenuItemFont *musicMenuItem = [CCMenuItemFont itemWithString:@"Music: ON" target:self selector:@selector(toggleMusic:)];
    musicMenuItem.fontName = @"CreativeBlockBB";
    musicMenuItem.fontSize = 30;
    musicMenuItem.position = ccp(sfxMenuItem.position.x + winSize.width/2.5, sfxMenuItem.position.y);
    
    // Set the strings to on/off
    if (![GameData sharedGameData].soundEffectsOn)
    {
        [sfxMenuItem setString:@"SFX: OFF"];
        NSLog(@"SFX Off");
        
    }
    if (![GameData sharedGameData].soundMusicOn)
        [musicMenuItem setString:@"Music: OFF"];
    
    soundMenu = [CCMenu menuWithItems:sfxMenuItem, musicMenuItem, nil];
    soundMenu.position = CGPointZero;
    [self addChild:soundMenu z:1 tag:994];
}

-(void)toggleSFX:(id)sender
// Changes the sfxMenuItem text as well as the actual setting
{
    if ([GameData sharedGameData].soundEffectsOn)
    {
        CCMenuItemFont *sfxItem = sender;
        [sfxItem setString:@"SFX: OFF"];
        [GameData sharedGameData].soundEffectsOn = NO;
    }
    else
    {
        CCMenuItemFont *sfxItem = sender;
        [sfxItem setString:@"SFX: ON"];
        [GameData sharedGameData].soundEffectsOn = YES;
        [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    }
}

-(void)toggleMusic:(id)sender
// Changes the sfxMenuItem text as well as the actual setting
{
    if ([GameData sharedGameData].soundMusicOn)
    {
        CCMenuItemFont *musicItem = sender;
        [musicItem setString:@"Music: OFF"];
        [GameData sharedGameData].soundMusicOn = NO;
        
        if ([GameData sharedGameData].soundEffectsOn)
            [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    }
    else
    {
        CCMenuItemFont *musicItem = sender;
        [musicItem setString:@"Music: ON"];
        [GameData sharedGameData].soundMusicOn = YES;
        
        if ([GameData sharedGameData].soundEffectsOn)
            [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    }
}

-(void)removeMainMenuButtons
// Removes main menu so that they aren't in the way while level menu is displayed
{
    CCMenu *mainMenu = (CCMenu *)[self getChildByTag:999];
    if (mainMenu != nil)
        [self removeChild:mainMenu cleanup:YES];
    CCMenu *backMenu = (CCMenu *)[self getChildByTag:998];
    if (backMenu != nil)
        [self removeChild:backMenu cleanup:YES];
    
    CCMenu *soundsMenu = (CCMenu *)[self getChildByTag:994];
    if (soundsMenu != nil)
    {
        NSLog(@"Removing soundMenu");
        [self removeChild:soundMenu cleanup:YES];
    }
    
    // Backgrounds of menu items
    CCLabelTTF *playBG = (CCLabelTTF *)[self getChildByTag:995];
    if (playBG != nil)
        [self removeChild:playBG cleanup:YES];
}

-(void)removeLevelMenuButtons
// Removes main menu so that they aren't in the way while level menu is displayed
{
    CCMenu *mainMenu = (CCMenu *)[self getChildByTag:999];
    if (mainMenu != nil)
        [self removeChild:mainMenu cleanup:YES];
    CCMenu *backMenu = (CCMenu *)[self getChildByTag:998];
    if (backMenu != nil)
        [self removeChild:backMenu cleanup:YES];
    CCLabelTTF *backBG = (CCLabelTTF *)[self getChildByTag:996];
    if (backBG != nil)
        [self removeChild:backBG cleanup:YES];
    if (menuGrid != nil)
    {
        [menuGrid removePageIndicator];
        [self removeChild:menuGrid cleanup:YES];
    }
}

-(void)backButtonPressed:(id)sender
{
    // Play sound
    if ([GameData sharedGameData].soundEffectsOn)
        [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    
    [self removeLevelMenuButtons];    
    [self showMainMenuButtons];
    [self unschedule:@selector(update:)];
}

-(void)showLevelMenu
// Builds and shows the level menu grid
{
    [self schedule:@selector(update:)];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Remove main menu items
    [self removeMainMenuButtons];
    
    // Show menu grid
    NSMutableArray *levelButtonItems = [[NSMutableArray alloc] init];
    for (int i = 1; i <= NUMBEROFLEVELS; i++)
    {
        CCMenuItemImage *item;
        
        // Level is unlocked
        if (i <= [GameData sharedGameData].levelsUnlocked)
        {
            // CHANGE TO SHOW CORRECT STARS FROM GAMEDATA
            BOOL starCollected = [[[GameData sharedGameData].starsCollectedArray objectAtIndex:(i - 1)] boolValue];
            
            if (!starCollected)
                item = [CCMenuItemImage itemWithNormalImage:@"LevelButtonNoStar.png"
                                                           selectedImage:@"LevelButtonNoStar.png"
                                                                  target:self
                                                                selector:@selector(levelSelected:)];
            else
                item = [CCMenuItemImage itemWithNormalImage:@"LevelButtonStar.png"
                                              selectedImage:@"LevelButtonStar.png"
                                                     target:self
                                                   selector:@selector(levelSelected:)];
        }
        // Level is locked
        else
        {
            item = [CCMenuItemImage itemWithNormalImage:@"LevelButtonLocked.png"
                                          selectedImage:@"LevelButtonLocked.png"
                                                 target:self
                                               selector:@selector(levelSelected:)];
        }
        
        
        [levelButtonItems addObject:item];
    }
    
    self.position = CGPointZero;
    menuGrid = [MenuGridLayer menuGridWithArray:levelButtonItems columns:5 rows:3 position:CGPointMake(62, winSize.height - 50) padding:CGPointMake(85, 95)]; // 5  3  62,250  85,95
    [self addChild:menuGrid z:2];
    
    // Add a back button
    //CCLabelTTF *backButton = [CCLabelTTF labelWithString:@"<- Back" fontName:@"CreativeBlockBB" fontSize:22];
    //backButton.color = ccc3(0, 0, 0);
    //backButton.tag = 998;
    CCMenuItemFont *backButton = [CCMenuItemFont itemWithString:@"<- Back" target:self selector:@selector(backButtonPressed:)];
    backButton.fontName = @"CreativeBlockBB";
    backButton.fontSize = 22;
    backButton.color = ccc3(255, 255, 255);
    backButton.anchorPoint = CGPointZero;
    backButton.position = ccp(-winSize.width/2 + 2, -winSize.height/2 + 3);
    CCMenu *backMenu = [CCMenu menuWithItems:backButton, nil];
    backMenu.tag = 998;
    CCLabelTTF *backBG = [CCLabelTTF labelWithString:@"<- Back" fontName:@"CreativeBlockBB" fontSize:22];
    backBG.color = ccc3(0, 0, 0);
    backBG.position = ccp(backBG.contentSize.width/2 + 4, backBG.contentSize.height/2 + 5);
    backBG.tag = 996;
    [self addChild:backBG z:3];
    //backButton.position = ccp(backButton.contentSize.width/2,backButton.contentSize.height/2);
    //[self addChild:backButton z:3];
    [self addChild:backMenu z:3];
}

-(void)levelSelected:(CCMenuItemImage *)sender
{
    // Level is locked, so return
    if ([GameData sharedGameData].levelsUnlocked < sender.tag)
    {
        return;
    }
    
    // Play sound
    if ([GameData sharedGameData].soundEffectsOn)
        [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    
    NSArray *subviews = [[[CCDirector sharedDirector]view] subviews];
    for (id sv in subviews)
    {
        [((UIView *)sv) removeFromSuperview];
        [sv release];
    }
    
    [GameData sharedGameData].currentLevel = sender.tag;

    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithLevel:sender.tag] withColor:ccWHITE]];
}

-(void)playButton:(id)sender
{ 
    // Play sound
    if ([GameData sharedGameData].soundEffectsOn)
        [[SimpleAudioEngine sharedEngine] playEffect:@"menuSelect.wav"];
    
    [self showLevelMenu];
}

-(void)update:(ccTime)dt
{
    if (menuGrid.backAreaTouched)
    {
        //[self backButtonPressed:self];
    }
}

@end
