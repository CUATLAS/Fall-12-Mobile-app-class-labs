//
//  ControlLayer.m
//  Twist
//
//  Created by Stephen Feuerstein on 8/20/12.
//  Copyright 2012 GingerSnAPPS. All rights reserved.
//

#import "ControlLayer.h"
#import "SimpleAudioEngine.h"

@implementation ControlLayer

@synthesize rightTapped;
@synthesize leftTapped;
@synthesize jumpTapped;
@synthesize twistTapped;
@synthesize onASwitch;
@synthesize timeLabel = timeLabel;
@synthesize levelLabel;

-(id)init
{
    if ((self = [super init]))
    {
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        gameData = [GameData sharedGameData];
        
        self.rightTapped = NO;
        self.leftTapped = NO;
        self.jumpTapped = NO;
        self.twistTapped = NO;
        self.onASwitch = NO;
        self.switchTapped = NO;
        
        inGravArea = NO;
        upArrowShowing = YES;
        delayingSwitchPress = NO;
        switchButtonDisplayed = NO;
        currentSwitchIsOn = NO;
        didTapPause = NO;
        
        // Button Sprites
        rightArrowButton = [CCSprite spriteWithFile:@"MoveArrow.png"];
        leftArrowButton = [CCSprite spriteWithFile:@"MoveArrow.png"];
        jumpButton = [CCSprite spriteWithFile:@"MoveArrow.png"];
        twistButton = [CCSprite spriteWithFile:@"TwistButton.png"]; // twistArrow
        
        rightArrowButton.position = ccp(winSize.width/4, rightArrowButton.contentSize.height * 0.5);
        leftArrowButton.rotation = 180; // Flip arrow around
        leftArrowButton.position = ccp(rightArrowButton.position.x - (rightArrowButton.contentSize.width * 1.25),
                                       rightArrowButton.position.y);
        
        //twistButton.rotation = 270;
        twistButton.position = ccp(winSize.width * 0.75, rightArrowButton.position.y);
        
        jumpButton.rotation = 270;
        jumpButton.position = ccp(twistButton.position.x + jumpButton.contentSize.width*1.25, rightArrowButton.position.y);
        
        pauseButton = [CCSprite spriteWithFile:@"PauseButton.png"];
        pauseButton.position = ccp(winSize.width - (pauseButton.contentSize.width/1.5), winSize.height - (pauseButton.contentSize.height/1.5));
        pauseButtonRect = CGRectMake(pauseButton.position.x - pauseButton.contentSize.width/2,
                                            pauseButton.position.y - pauseButton.contentSize.height/2,
                                            pauseButton.contentSize.width,
                                            pauseButton.contentSize.height);
        
        // Draw black rectangle for background of buttons
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"controlBGBlack.png"];
        bgSprite.position = ccp(winSize.width/2, leftArrowButton.position.y);
        bgSprite.scaleX = (winSize.width / bgSprite.contentSize.width);
        bgSprite.scaleY = ((leftArrowButton.contentSize.height * 1.25) / bgSprite.contentSize.height);
        
        [self addChild:bgSprite z:-1];
        [self addChild:rightArrowButton];
        [self addChild:leftArrowButton];
        [self addChild:jumpButton];
        [self addChild:twistButton];
        [self addChild:pauseButton];
        
        // Start time at 0
        timeLabel = [CCLabelTTF labelWithString:@"0:0.0" fontName:@"CreativeBlockBB" fontSize:18];
        timeLabel.color = ccc3(255, 255, 255);
        timeLabel.position = ccp(winSize.width/2 - 20, 32);
        timeLabel.anchorPoint = CGPointZero;
        [self addChild:timeLabel z:5];
        
        // Show level
        levelLabel = [CCLabelTTF labelWithString:@"Level: 0" fontName:@"CreativeBlockBB" fontSize:18];
        levelLabel.position = ccp(timeLabel.position.x + timeLabel.contentSize.width/2, timeLabel.position.y - (levelLabel.contentSize.height + 5));
        [self addChild:levelLabel];
        
        [self schedule:@selector(update:)];
    }
    return self;
}

-(void)setSwitchButtonWithBool:(BOOL)switchIsOnBool
{
    if (switchIsOnBool)
    {
        [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOn.png"]];
        currentSwitchIsOn = YES;
    }
    else
    {
        [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOff.png"]];
        currentSwitchIsOn = NO;
    }
}

// These two methods gray out the twist button, or make it active
-(void)grayOutTwistButton
{
    twistButton.opacity = 100;
    inGravArea = NO;
}
-(void)makeTwistButtonActive
{
    twistButton.opacity = 255;
    inGravArea = YES;
}

// These two methods change the twist button to be active for switching,
// or gray it out and revert it to a twist button again
-(void)grayOutSwitchButton
{
    // Reset to twist button instead of switch
    [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButton.png"]];
    twistButton.opacity = 100;
    inGravArea = NO;
    switchButtonDisplayed = NO;
}
-(void)makeSwitchButtonActive
{
    // Change image if not displayed
    if (!switchButtonDisplayed)
    {
        if (currentSwitchIsOn)
            [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOn.png"]];
        else
            [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOff.png"]];
        switchButtonDisplayed = YES;
    }
    twistButton.opacity = 255;
    inGravArea = YES;
}

-(void)enableSwitches
{
    delayingSwitchPress = NO;
}

-(void)delaySwitchPress
// Delay switch pressing for 1 second, then re-enable
{
    delayingSwitchPress = YES;
    
    id pauseAction = [CCDelayTime actionWithDuration:0.4];
    id enableSwitches = [CCCallFuncN actionWithTarget:self selector:@selector(enableSwitches)];
    id sequence = [CCSequence actionOne:pauseAction two:enableSwitches];
    
    [self runAction:sequence];
}

-(BOOL)pauseButtonTapped
{
    if (didTapPause)
    {
        didTapPause = NO;
        return YES;
    }
    return NO;
}

-(void)update:(ccTime)dt
{
    // Check for inverted gravity and rotate jump button
    if (gameData.twistButtonPressed)
    {
        jumpButton.rotation = 90;
    }
    else
    {
        jumpButton.rotation = 270;
    }
    
    // Check for being on a switch
    if (onASwitch)
    {
        [self makeSwitchButtonActive]; // CHANGE TO MAKE SWITCH BUTTON ACTIVE
        //twistButton.rotation = 0;
    }
    else
    {
        [self grayOutSwitchButton]; // CHANGE TO GRAY OUT SWITCH BUTTON (changing image texture back)
        //twistButton.rotation = 270;
    }
    
    // Check for gravity area and change twist button
    if (!gameData.canFlipGravity && !onASwitch)
    {
        [self grayOutTwistButton];
    }
    else if (gameData.canFlipGravity && !onASwitch)
    {
        [self makeTwistButtonActive];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect leftArrowRect = CGRectMake(leftArrowButton.position.x - leftArrowButton.contentSize.width/2,
                                      leftArrowButton.position.y - leftArrowButton.contentSize.height/2,
                                      leftArrowButton.contentSize.width,
                                      leftArrowButton.contentSize.height);
    CGRect rightArrowRect = CGRectMake(rightArrowButton.position.x - rightArrowButton.contentSize.width/2,
                                      rightArrowButton.position.y - rightArrowButton.contentSize.height/2,
                                      rightArrowButton.contentSize.width,
                                      rightArrowButton.contentSize.height);
    CGRect jumpButtonRect = CGRectMake(jumpButton.position.x - jumpButton.contentSize.width/2,
                                       jumpButton.position.y - jumpButton.contentSize.height/2,
                                       jumpButton.contentSize.width,
                                       jumpButton.contentSize.height);
    CGRect twistButtonRect = CGRectMake(twistButton.position.x - twistButton.contentSize.width/2,
                                       twistButton.position.y - twistButton.contentSize.height/2,
                                       twistButton.contentSize.width,
                                       twistButton.contentSize.height);
    for (UITouch *t in touches)
    {
        CGPoint touchLocation = [self convertTouchToNodeSpace:t];
        //CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
        
        // If touch in left arrow box
        if (CGRectContainsPoint(leftArrowRect, touchLocation))
        {
            [leftArrowButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrowSelected.png"]];
            self.leftTapped = YES;
            gameData.leftButtonPressed = YES;
        }
        
        // If touch in right arrow box
        if (CGRectContainsPoint(rightArrowRect, touchLocation))
        {
            [rightArrowButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrowSelected.png"]];
            self.rightTapped = YES;
            gameData.rightButtonPressed = YES;
        }
        
        // If touch in jump button box
        if (CGRectContainsPoint(jumpButtonRect, touchLocation))
        {
            [jumpButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrowSelected.png"]];
            self.jumpTapped = YES;
            gameData.jumpButtonPressed = YES;
        }
        
        // If touch in twist button box
        if (CGRectContainsPoint(twistButtonRect, touchLocation))
        {
            if (!inGravArea && !onASwitch)
                return;
            
            if (onASwitch && !self.switchTapped && !delayingSwitchPress)
            {
                self.switchTapped = YES;
                [self delaySwitchPress];
                
                // Play switch sound
            }
            else
            {
                self.switchTapped = NO;
            }
            
            if (upArrowShowing)
            {
                [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButtonSelected.png"]]; // twistArrowSelected
            }
            else
            {
                [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButtonSelected.png"]]; // MoveArrowSelected
            }
            self.twistTapped = YES;
            
            // If on a switch
            if (onASwitch)
            {
                if (currentSwitchIsOn)
                    [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOnSelected.png"]];
                else
                    [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOffSelected.png"]];
            }
            
        }
        
        // If touch is in pause button box
        if (CGRectContainsPoint(pauseButtonRect, touchLocation))
        {
            didTapPause = YES;
        }
    }
}


-(void)flipGravityBOOL
{
    if (gameData.canFlipGravity)
    {
        // Play sound
        if ([GameData sharedGameData].soundEffectsOn)
            [[SimpleAudioEngine sharedEngine] playEffect:@"flipGrav.wav"];
        
        if (gameData.twistButtonPressed)
        {
            gameData.twistButtonPressed = NO;

            // Switch button to orange
            [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButton.png"]]; // twistArrow
            //twistButton.rotation = 270;
            upArrowShowing = YES;
        }
        else
        {
            gameData.twistButtonPressed = YES;
            
            // Switch button to blue
            [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButton.png"]]; // MoveArrow
            //twistButton.rotation = 90;
            upArrowShowing = NO;
        }
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect leftArrowRect = CGRectMake(leftArrowButton.position.x - leftArrowButton.contentSize.width/2,
                                      leftArrowButton.position.y - leftArrowButton.contentSize.height/2,
                                      leftArrowButton.contentSize.width,
                                      leftArrowButton.contentSize.height);
    CGRect rightArrowRect = CGRectMake(rightArrowButton.position.x - rightArrowButton.contentSize.width/2,
                                       rightArrowButton.position.y - rightArrowButton.contentSize.height/2,
                                       rightArrowButton.contentSize.width,
                                       rightArrowButton.contentSize.height);
    CGRect jumpButtonRect = CGRectMake(jumpButton.position.x - jumpButton.contentSize.width/2,
                                       jumpButton.position.y - jumpButton.contentSize.height/2,
                                       jumpButton.contentSize.width,
                                       jumpButton.contentSize.height);
    CGRect twistButtonRect = CGRectMake(twistButton.position.x - twistButton.contentSize.width/2,
                                        twistButton.position.y - twistButton.contentSize.height/2,
                                        twistButton.contentSize.width,
                                        twistButton.contentSize.height);
    
    for (UITouch *t in touches)
    {
        self.switchTapped = NO;
        
        CGPoint touchLocation = [self convertTouchToNodeSpace:t];
        
        // previous touch location
        CGPoint previousTouchLocation = [t previousLocationInView:[t view]];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        previousTouchLocation = ccp(previousTouchLocation.x, winSize.height - previousTouchLocation.y);
        
        // #### Movement Between Buttons ####
        // Touch moved OFF LEFT arrow
        if (!(CGRectContainsPoint(leftArrowRect, touchLocation)) &&
              CGRectContainsPoint(leftArrowRect, previousTouchLocation))
        {
            self.leftTapped = NO;
            gameData.leftButtonPressed = NO;
            [leftArrowButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrow.png"]];
        }
        
        // Touch moved OFF RIGHT arrow
        if (!(CGRectContainsPoint(rightArrowRect, touchLocation)) &&
              CGRectContainsPoint(rightArrowRect, previousTouchLocation))
        {
            self.rightTapped = NO;
            gameData.rightButtonPressed = NO;
            [rightArrowButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrow.png"]];
        }
        
        // Touch moved OFF JUMP button
        if (!(CGRectContainsPoint(jumpButtonRect, touchLocation)) &&
              CGRectContainsPoint(jumpButtonRect, previousTouchLocation))
        {
            self.jumpTapped = NO;
            gameData.jumpButtonPressed = NO;
            [jumpButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrow.png"]];
        }
        
        // Touch moved OFF TWIST button
        if (!(CGRectContainsPoint(twistButtonRect, touchLocation)) &&
            CGRectContainsPoint(twistButtonRect, previousTouchLocation))
        {
            if (!inGravArea)
                return;
            self.twistTapped = NO;
            [self flipGravityBOOL];
            
            if (upArrowShowing)
            {
                [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButton.png"]]; // twistArrow
            }
            else
            {
                [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButton.png"]]; // MoveArrow
            }
            
            // If on a switch
            if (onASwitch)
            {
                if (currentSwitchIsOn)
                    [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOn.png"]];
                else
                    [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOff.png"]];
            }
        }
        // #### End Movement Between Buttons ####
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.switchTapped = NO;
    
    CGRect leftArrowRect = CGRectMake(leftArrowButton.position.x - leftArrowButton.contentSize.width/2,
                                      leftArrowButton.position.y - leftArrowButton.contentSize.height/2,
                                      leftArrowButton.contentSize.width,
                                      leftArrowButton.contentSize.height);
    CGRect rightArrowRect = CGRectMake(rightArrowButton.position.x - rightArrowButton.contentSize.width/2,
                                       rightArrowButton.position.y - rightArrowButton.contentSize.height/2,
                                       rightArrowButton.contentSize.width,
                                       rightArrowButton.contentSize.height);
    CGRect jumpButtonRect = CGRectMake(jumpButton.position.x - jumpButton.contentSize.width/2,
                                       jumpButton.position.y - jumpButton.contentSize.height/2,
                                       jumpButton.contentSize.width,
                                       jumpButton.contentSize.height);
    CGRect twistButtonRect = CGRectMake(twistButton.position.x - twistButton.contentSize.width/2,
                                        twistButton.position.y - twistButton.contentSize.height/2,
                                        twistButton.contentSize.width,
                                        twistButton.contentSize.height);
    
    for (UITouch *t in touches)
    {        
        CGPoint touchLocation = [self convertTouchToNodeSpace:t];
        
        // OFF LEFT arrow
        if (CGRectContainsPoint(leftArrowRect, touchLocation))
        {
            [leftArrowButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrow.png"]];
            self.leftTapped = NO;
            gameData.leftButtonPressed = NO;
        }
        
        // OFF RIGHT arrow
        if (CGRectContainsPoint(rightArrowRect, touchLocation))
        {
            [rightArrowButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrow.png"]];
            self.rightTapped = NO;
            gameData.rightButtonPressed = NO;
        }
        
        // OFF JUMP button
        if (CGRectContainsPoint(jumpButtonRect, touchLocation))
        {
            [jumpButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"MoveArrow.png"]];
            self.jumpTapped = NO;
            gameData.jumpButtonPressed = NO;
        }
        
        // OFF TWIST button
        if (CGRectContainsPoint(twistButtonRect, touchLocation))
        {
            if (!inGravArea)
                return;
            
            if (upArrowShowing)
            {
                [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButton.png"]]; // twistArrow
            }
            else
            {
                [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"TwistButton.png"]]; // MoveArrow
            }
            
            // If on a switch
            if (onASwitch)
            {
                if (currentSwitchIsOn)
                    [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOn.png"]];
                else
                    [twistButton setTexture:[[CCTextureCache sharedTextureCache] addImage:@"SwitchButtonOff.png"]];
            }
            
            self.twistTapped = NO;
            [self flipGravityBOOL];
        }
    }
}

-(void)dealloc
{
    //[rightArrowButton release];
    //[leftArrowButton release];
    //[jumpButton release];
    [super dealloc];
}

@end
