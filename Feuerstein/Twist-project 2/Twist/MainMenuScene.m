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
        CCLayerColor *blueColor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:blueColor z:0];

        [self showMainMenuButtons];
        
        self.position = CGPointZero;
        self.anchorPoint = CGPointZero;
        
        // TESTING WITH GAME DATA
        GameData *gameData = [GameData sharedGameData];
        if (!gameData.playCount) // No plays yet
        {
            // Set all default values
            [GameData sharedGameData].levelsUnlocked = 2;
        }
        gameData.playCount++;
        // END TESTING WITH GAME DATA
    }
    return self;
}

-(void)showMainMenuButtons
// Displays the main menu items including play, options, etc.
{
    //CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItem *menuItem1 = [CCMenuItemFont itemWithString:@"Play" target:self selector:@selector(playButton:)];
    
    CCMenu *menu = [CCMenu menuWithItems:menuItem1, nil];
    menu.color = ccc3(0, 0, 0);
    [menu alignItemsVertically];
    [self addChild:menu z:1 tag:999];
}

-(void)removeMainMenuButtons
// Removes main menu so that they aren't in the way while level menu is displayed
{
    CCMenu *mainMenu = (CCMenu *)[self getChildByTag:999];
    if (mainMenu != nil)
        [self removeChild:mainMenu cleanup:YES];
    CCLabelTTF *backLabel = (CCLabelTTF *)[self getChildByTag:998];
    if (backLabel != nil)
        [self removeChild:backLabel cleanup:YES];
}

-(void)removeLevelMenuButtons
// Removes main menu so that they aren't in the way while level menu is displayed
{
    CCMenu *mainMenu = (CCMenu *)[self getChildByTag:999];
    if (mainMenu != nil)
        [self removeChild:mainMenu cleanup:YES];
    CCLabelTTF *backLabel = (CCLabelTTF *)[self getChildByTag:998];
    if (backLabel != nil)
        [self removeChild:backLabel cleanup:YES];
    if (menuGrid != nil)
        [self removeChild:menuGrid cleanup:YES];
}

-(void)backButtonPressed:(id)sender
{
    NSLog(@"Back Button Pressed");
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
    for (int i = 1; i < NUMBEROFLEVELS; i++)
    {
        CCMenuItemImage *item;
        
        // Level is unlocked
        if (i <= [GameData sharedGameData].levelsUnlocked)
        {
            if (i >= 2)
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
    CCLabelTTF *backButton = [CCLabelTTF labelWithString:@"<- Back" fontName:@"CreativeBlockBB" fontSize:22];
    backButton.color = ccc3(0, 0, 0);
    backButton.tag = 998;
    
    backButton.position = ccp(backButton.contentSize.width/2,backButton.contentSize.height/2);
    [self addChild:backButton z:3];
}

-(void)levelSelected:(CCMenuItemImage *)sender
{
    // Level is locked, so return
    if ([GameData sharedGameData].levelsUnlocked < sender.tag)
    {
        return;
    }
    
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
    NSLog(@"Switching to Level Menu");
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithLevel:1] withColor:ccWHITE]];
    [self showLevelMenu];
}

-(void)update:(ccTime)dt
{
    if (menuGrid.backAreaTouched)
    {
        [self backButtonPressed:self];
    }
}

@end
