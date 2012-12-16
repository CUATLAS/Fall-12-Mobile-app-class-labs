//
//  Player.m
//  Twist
//
//  Created by Stephen Feuerstein on 8/6/12.
//  Copyright 2012 GingerSnAPPS. All rights reserved.
//

#import "Player.h"
#import "Constants.h"
#import "GameData.h"

@implementation Player

@synthesize velocity;
@synthesize desiredPosition;
@synthesize onGround;
@synthesize moveLeft;
@synthesize moveRight;
@synthesize runAction;
@synthesize jump;
@synthesize isRed;
@synthesize displayingArrows;

@synthesize previousGravityRegular;
@synthesize canFlipGravity;

@synthesize isGlowing;

@synthesize animationTime;

-(id)init
{
    if (self = [super init])
    {
        facingRight = YES;
        isRunning = NO;
        inAir = NO;
        glowIncreasing = NO;
        displayingDust = NO;
        
        // Sound
        playingRunSound = NO;
        footSteps = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:@"footsteps.wav"] retain];
        //footSteps.pitch *= -2;
        
        self.velocity = ccp(0.0, 0.0);
        self.onGround = NO;
        
        // Movement BOOLs
        self.moveLeft = NO;
        self.moveRight = NO;
        self.jump = NO;
        self.canFlipGravity = NO;
        
        // Set the player to black color to start
        //[self setColor:ccc3(0, 0, 0)];
        
        // Gravity inversion animation
        self.isRed = NO;
        self.displayingArrows = NO;
        self.previousGravityRegular = YES;
        
        // Update for if glowing
        [self schedule:@selector(glowUpdate:)];
        self.isGlowing = NO;
        
        // Set default animation time
        self.animationTime = 0.75;
    
        // Run cycle sprite cache
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"playerRunning.plist"]; // stickAnim.plist
        CCSpriteBatchNode *runSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"playerRunning.png"]; // stickAnim.png
        [self addChild:runSpriteSheet z:15];
        // Create array and add frames for animation
        NSMutableArray *runAnimFrames = [NSMutableArray array];
        for (int i = 1; i <= 8; i++) // 4
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
            [runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache]
              spriteFrameByName:[NSString stringWithFormat:@"playerRunning%d.png", i]]]; // stickRun%d.png
        }
        CCAnimation *runAnimation = [CCAnimation animationWithSpriteFrames:runAnimFrames delay:0.08f]; // 0.12
        self.runAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnimation]];
        [self runAction:self.runAction];
        //[self stopAction:self.runAction];
        //self = [CCSprite spriteWithSpriteFrameName:@"stickRun1.png"];
    }
    return self;
}

-(CGRect)collisionBoundingBox
// Returns a bounding box that is slightly smaller than the sprite in width,
// and is adjusted to be in the target position
{
    CGRect collisionBox = CGRectInset(self.boundingBox, 3, 0);
    CGPoint diff = ccpSub(self.desiredPosition, self.position);
    CGRect returnBoundingBox = CGRectOffset(collisionBox, diff.x, diff.y);
    return returnBoundingBox;
}

-(void)cleanupDustKickup:(CCSprite *)particle
{
    [self.parent removeChild:particle cleanup:YES];
    displayingDust = NO;
}

-(void)displayDustKickup
// Displays dust particles at the player's feet when they slide to a stop
{    
    displayingDust = YES;
    
    float maxPositionMoveX = 10.0;
    float maxPositionMoveY = 6.75;
    float minPositionMove = 5.0;
    float lifespan = 0.45;
    int numberOfParticles = 7;
    
    for (int i = 0; i < numberOfParticles; i++)
    {
        CCSprite *particle = [CCSprite spriteWithFile:@"dustParticle.png"]; // CHANGE TO DUST PARTICLE
        
        float randomScale = ((float)arc4random() / ARC4RANDOM_MAX) * 1.5;
        particle.scale = randomScale;
        
        float randomXOffset = ((float)arc4random() / ARC4RANDOM_MAX) * (self.contentSize.width * 2.5);
        if (arc4random() % 2 == 0)
            randomXOffset *= -1;
        
        particle.position = CGPointZero;
        // Set particle start position to the right side of the player if moving right, otherwise left
        if (self.velocity.x > 0)
            particle.position = ccp(particle.position.x + self.contentSize.width*0.9, particle.position.y);
        else
            particle.position = ccp(particle.position.x + self.contentSize.width*0.1, particle.position.y);
        // Update to top of sprite if gravity is flipped
        if ([GameData sharedGameData].twistButtonPressed)
            particle.position = ccp(particle.position.x, particle.position.y + self.contentSize.height);
        
        particle.color = ccc3(200, 200, 175);
        
        [self addChild:particle z:1];
        
        CGPoint moveByAmount;
        float moveX = ((float)arc4random() / ARC4RANDOM_MAX) * maxPositionMoveX;
        if (moveX < minPositionMove)
            moveX = minPositionMove;

        // Move particles left if moving left, otherwise keep movement to the right
        if (self.velocity.x < 0)
            moveX *= -1;
        
        float moveY = ((float)arc4random() / ARC4RANDOM_MAX) * maxPositionMoveY;
        if (moveY < minPositionMove)
            moveY = minPositionMove;
        // Invert moveY if gravity is flipped
        if ([GameData sharedGameData].twistButtonPressed)
            moveY *= -1;
        
        moveByAmount = ccp(moveX, moveY);
        
        // Actions for fading out, moving, and cleaning up each particle
        id fadeAction = [CCFadeOut actionWithDuration:(0.6 * lifespan)];
        id moveAction = [CCMoveBy actionWithDuration:(0.75 * lifespan) position:moveByAmount];
        id cleanUpAction = [CCCallFuncND actionWithTarget:self selector:@selector(cleanupDustKickup:) data:particle];
        id sequence = [CCSequence actionOne:moveAction two:cleanUpAction];
        
        [particle runAction:fadeAction];
        [particle runAction:sequence];
    }
}

-(void)cleanupArrows:(CCSprite *)cleanupSprite
{
    [self.parent removeChild:cleanupSprite cleanup:YES];
    self.displayingArrows = NO;
}

-(void)displayArrowAnimationWithRotation:(int)rot
// Displays arrows facing in the direction of the gravity when changed
{
    NSMutableArray *arrowArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 7; i++)
    {
        CCSprite *arrow = [CCSprite spriteWithFile:@"gravArrow.png"];
        arrow.flipY = rot - 180;
        
        float randomScale = ((float)arc4random() / ARC4RANDOM_MAX) * 1.5;
        arrow.scale = randomScale; // Random sizing on arrows
        
        float randomXOffset = ((float)arc4random() / ARC4RANDOM_MAX) * (self.contentSize.width * 2.5);
        if (arc4random() % 2 == 0)
            randomXOffset *= -1;
        float randomYOffset = ((float)arc4random() / ARC4RANDOM_MAX) * (self.contentSize.height / 2);
        if (arc4random() % 2 == 0)
            randomYOffset *= -1;
        
        arrow.position = ccp(self.position.x + randomXOffset, self.position.y + randomYOffset);
        
        // Set color of arrow based on gravity
        if ([GameData sharedGameData].twistButtonPressed)
            arrow.color = ccc3(255, 100, 0);
        else
            arrow.color = ccc3(0, 50, 255);
        
        // Check for overlap with other arrows
        for (int i = 0; i < arrowArray.count; i++)
        {
            CCSprite *compareArrow = [arrowArray objectAtIndex:i];
            
            // If intersection and new arrow to the right
            if (CGRectIntersectsRect(arrow.boundingBox, compareArrow.boundingBox) &&
                arrow.position.x > compareArrow.position.x)
                arrow.position = ccp(arrow.position.x + arrow.contentSize.width, arrow.position.y);
            
            // If intersection and new arrow to the left
            if (CGRectIntersectsRect(arrow.boundingBox, compareArrow.boundingBox) &&
                arrow.position.x < compareArrow.position.x)
                arrow.position = ccp(arrow.position.x - arrow.contentSize.width, arrow.position.y);
        }
        [arrowArray addObject:arrow];

        [self.parent addChild:arrow z:1];
        
        // Animate with fading out, then removing sprite
        id fadeAnimation = [CCFadeOut actionWithDuration:0.85];
        id removeAction = [CCCallFuncND actionWithTarget:self selector:@selector(cleanupArrows:) data:arrow];
        id sequence = [CCSequence actions:fadeAnimation, removeAction, nil];
        [arrow runAction:sequence];
    }
}

-(void)addGravGlow
// Adds a glow around the player when you are in an area where
// gravity flipping in allowed. Color changes to match arrows
{
    if ([self getChildByTag:6])
    {
        return;
    }
    else
    {
        CCSprite *glowSprite = [CCSprite spriteWithFile:@"gravGlow.png"];
        CGPoint newPos = ccp(CGPointZero.x + self.contentSize.width/2,
                             CGPointZero.y + self.contentSize.height/2);
        glowSprite.position = newPos;
        glowSprite.tag = 6;
        glowSprite.scale = 0.9;
        glowSprite.opacity = 50;
        glowSprite.color = ccc3(255, 100, 0);
        
        // Change to blue if the player is upside down
        if ([GameData sharedGameData].twistButtonPressed)
        {
            glowSprite.flipY = 180;
            glowSprite.color = ccc3(0, 50, 255);
        }
    
        [self addChild:glowSprite z:-1];
        [self unschedule:@selector(glowUpdate:)];
        [self schedule:@selector(glowUpdate:)];
    }

    self.isGlowing = YES;
}

-(void)removeGravGlow
// Removes the glow if it exists and the player is no longer in
// a gravTile area (or is not on the ground)
{
    if (![self getChildByTag:6])
    {
        return;
    }
    else
    {
        [self removeChildByTag:6 cleanup:YES];
        self.isGlowing = NO;
        [self unschedule:@selector(glowUpdate:)];
    }
}

-(void)glowUpdate:(ccTime)dt
// Fades glow in and out if over grav tiles
{
    if (self.isGlowing)
    {
        CCSprite *glowSprite = (CCSprite *)[self getChildByTag:6];
        
        // Glow is increasing
        if (glowIncreasing)
        {
            glowSprite.opacity += 3;
            glowSprite.scale += 0.002;
            if (glowSprite.opacity >= 250)
            {
                glowIncreasing = NO;
            }
        }
        
        // Glow is decreasing
        else
        {
            glowSprite.opacity -= 3;
            glowSprite.scale -= 0.002;
            if (glowSprite.opacity <= 150)
            {
                glowIncreasing = YES;
            }
        }
    }
}

-(void)update:(ccTime)dt
// Runs all necessary calculations for gravity, user input, etc
// and updates the player's position accordingly. Also, graphics
// for effects (arrows, glow, etc.) are called here if necessary
{
    if (([GameData sharedGameData].soundEffectsOn) &&isRunning && !playingRunSound)
    {
        playingRunSound = YES;
        [footSteps play];
    }
    
    if (([GameData sharedGameData].soundEffectsOn) && footSteps != nil && ![footSteps isPlaying])
        playingRunSound = NO;
    
    CGPoint previousVelocity = self.velocity; // For use in dust kick up check
    
    if (!self.onGround)
    {
        [GameData sharedGameData].canFlipGravity = NO;
        //inAir = YES;
    }
    else
    {
        inAir = NO;
    }
    
    // Set rotation based on gravity
    if ([GameData sharedGameData].twistButtonPressed)
    {
        self.flipY = 180;
        
        // Arrow Graphics
        if (!self.displayingArrows && self.previousGravityRegular)
        {
            [self displayArrowAnimationWithRotation:self.flipY];
            self.displayingArrows = YES;
            self.previousGravityRegular = NO;
            inAir = YES;
        }
    }
    else
    {
        self.flipY = 0;
        
        // Arrow Graphics
        if (!self.displayingArrows && !self.previousGravityRegular)
        {
            [self displayArrowAnimationWithRotation:self.flipY];
            self.displayingArrows = YES;
            self.previousGravityRegular = YES;
            inAir = YES;
        }
    }
    
    // Gravity Glow
    if ([GameData sharedGameData].canFlipGravity || self.canFlipGravity)
    {
        [self addGravGlow];
    }
    else
    {
        if (self.isGlowing)
            [self removeGravGlow];
    }
    
    // Default Gravity
    CGPoint gravity;
    if ([GameData sharedGameData].twistButtonPressed)
        gravity = ccp(0.0, -GRAVITYCONST);
    else
        //gravity = ccp(0,-10);
        gravity = ccp(0.0, GRAVITYCONST);
    
    // Fraction of gravity to act per tick
    CGPoint gravityStep = ccpMult(gravity, dt);
    
    // Move Force
    CGPoint rightMoveForce = ccp(MAXHORIZONTALMOVEFORCE, 0.0);
    CGPoint rightMoveStep = ccpMult(rightMoveForce, dt);
    CGPoint leftMoveForce = ccp(-MAXHORIZONTALMOVEFORCE, 0.0);
    CGPoint leftMoveStep = ccpMult(leftMoveForce, dt);
        
    self.velocity = ccpAdd(self.velocity, gravityStep);
    
    // Friction to not stop player immediately
    self.velocity = ccp(self.velocity.x * 0.9, self.velocity.y);
    
    // #### Jump ####
    CGPoint jumpForce;
    if ([GameData sharedGameData].twistButtonPressed)
        jumpForce = ccp(0.0, -JUMPFORCECONST);
    else
        jumpForce = ccp(0.0, JUMPFORCECONST);
    
    float minJumpHeight = MINJUMPHEIGHT;
    
    // When on ground and gravity not flipped
    if (![GameData sharedGameData].twistButtonPressed)
    {
        if (self.jump && self.onGround)
        {
            self.velocity = ccpAdd(self.velocity, jumpForce);
            self.onGround = NO;
            inAir = YES;
            
            // Play Sound
            if ([GameData sharedGameData].soundEffectsOn)
                [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
        }
        else if (!self.jump && self.velocity.y > minJumpHeight)
        {
            self.velocity = ccp(self.velocity.x, minJumpHeight);
        }
    }
    
    // When on ground and gravity IS flipped
    if ([GameData sharedGameData].twistButtonPressed)
    {
        if (self.jump && self.onGround)
        {
            self.velocity = ccpAdd(self.velocity, jumpForce);
            self.onGround = NO;
            inAir = YES;
            
            // Play Sound
            if ([GameData sharedGameData].soundEffectsOn)
                [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
        }
        else if (!self.jump && self.velocity.y < -minJumpHeight)
        {
            self.velocity = ccp(self.velocity.x, -minJumpHeight);
        }
    }
    // #### End Jump ####
    
    // Move Right
    if (self.moveRight)
    {
        self.velocity = ccpAdd(self.velocity, rightMoveStep);
        
        if (!isRunning)
        {
            [self runAction:self.runAction];
            isRunning = YES;
        }
    }
    
    // Move Left
    else if (self.moveLeft)
    {
        self.velocity = ccpAdd(self.velocity, leftMoveStep);
        
        if (!isRunning && self.onGround)
        {
            [self runAction:self.runAction];
            isRunning = YES;
        }
    }
    
    // Stopped running
    if ((!self.moveLeft && !self.moveRight) || self.jump || inAir)
    {
        [self stopAction:self.runAction];
        isRunning = NO;
        // Set to standing frame when not running
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"playerRunning4.png"]]; // stickRun2.png
        if (inAir)
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"playerRunning5.png"]];
    }
    
    // Set maximum move speeds
    CGPoint minMovement;
    CGPoint maxMovement;
    if ([GameData sharedGameData].twistButtonPressed)
    {
        minMovement = ccp(-MAXHORIZONTALMOVESPEED, -250.0);
        maxMovement = ccp(MAXHORIZONTALMOVESPEED, 450.0);
    }
    else
    {
        minMovement = ccp(-MAXHORIZONTALMOVESPEED, -450.0);
        maxMovement = ccp(MAXHORIZONTALMOVESPEED, 250.0);
    }
    
    self.velocity = ccpClamp(self.velocity, minMovement, maxMovement);
    
    CGPoint velocityStep = ccpMult(self.velocity, dt);
    
    // If going off the screen to the left, set velocity to 0
    if ((self.position.x + velocityStep.x) < 20)
        velocityStep = ccp(0.0, velocityStep.y);
    
    // Flip sprite if facing the wrong direction for movement
    if ((self.velocity.x < 0) && facingRight)
    {
        self.flipX = 180;
        facingRight = NO;
    }
    if ((self.velocity.x > 0) && !facingRight)
    {
        self.flipX = 0;
        facingRight = YES;
    }
    
    if (self.onGround && self.desiredPosition.y < self.position.y)
        velocityStep = ccp(velocityStep.x, 0);
    
    self.desiredPosition = ccpAdd(self.position, velocityStep);
    
    // Check for the player slowing down after moving fast enough, and kick up dust
    float tempVelX = self.velocity.x;
    if (tempVelX < 0)
        tempVelX *= -1;
    if (self.onGround
        && abs(self.velocity.x) < (abs(previousVelocity.x))
        && abs(tempVelX) > MAXHORIZONTALMOVESPEED/1.2
        && !displayingDust)
    {
        //[self displayDustKickup];
    }
}

-(void)removeDeathParticles
{
    // Lava particles
    if ([self getChildByTag:1111] != nil)
        [self removeChildByTag:1111 cleanup:YES];
    
    self.opacity = 0;
    [self unscheduleAllSelectors];
}

-(void)addTeleportFlash
{
    CCParticleSystemQuad *flash = [CCParticleSystemQuad particleWithFile:@"teleportFlash.plist"];
    flash.position = CGPointZero;
    flash.position = ccp(flash.position.x + self.contentSize.width/2,
                                     flash.position.y + self.contentSize.height/2);
    [self addChild:flash z:3];
}

-(void)animateLevelExit
// Executes the teleporting out animation for the character
{
    [self unscheduleAllSelectors];
    [self stopAllActions];
    
    // Change frame to a standing frame
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"playerRunning4.png"]];
    
    self.animationTime = 1.25;
    
    // Fade the player to blue/out
    id fadeToWhiteAction = [CCTintTo actionWithDuration:(0.5) red:0 green:0 blue:255];
    [self runAction:fadeToWhiteAction];
    id fadeOutAction = [CCFadeOut actionWithDuration:0.5];
    [self runAction:fadeOutAction];
    
    // Add teleport particles
    CCParticleSystemQuad *teleportParticles = [CCParticleSystemQuad particleWithFile:@"teleportParticles.plist"];
    teleportParticles.position = CGPointZero;
    teleportParticles.position = ccp(teleportParticles.position.x + self.contentSize.width/2,
                                     teleportParticles.position.y + self.contentSize.height/2);
    [self addChild:teleportParticles z:3];
    
    // Play Sound
    if ([GameData sharedGameData].soundEffectsOn)
        [[SimpleAudioEngine sharedEngine] playEffect:@"teleportOut.wav"];
    
    // Add flash
    id delayForFlash = [CCDelayTime actionWithDuration:animationTime - 0.25];
    id flashAction = [CCCallFuncN actionWithTarget:self selector:@selector(addTeleportFlash)];
    CCSequence *flashSequence = [CCSequence actionOne:delayForFlash two:flashAction];
    [self runAction:flashSequence];
}

-(void)animateDeathForHazardType:(NSString *)hazardType
// Executes the appropriate animation for the player's death
// based on the type of hazard the player collided with
{
    [self unscheduleAllSelectors];
    
    // Lava Collision
    if (hazardType == HAZARDTYPELAVA)
    {
        self.animationTime = 0.75; // Time that the animation will last
        
        // Sink into lava
        [self.parent reorderChild:self z:2];
        id movePlayerAction = [CCMoveBy actionWithDuration:self.animationTime position:ccp(0,-self.contentSize.height)];
        [self runAction:movePlayerAction];
        
        // Set player color to red to begin with
        self.color = ccc3(255, 0, 0);
        
        // Climbing fire particles
        CCParticleSystemQuad *lavaDeathParticles = [CCParticleSystemQuad particleWithFile:@"lavaDeathParticles.plist"];
        lavaDeathParticles.position = CGPointZero;
        lavaDeathParticles.position = ccp(lavaDeathParticles.position.x + self.contentSize.width/2, lavaDeathParticles.position.y);
        lavaDeathParticles.tag = 1111;
        [self addChild:lavaDeathParticles z:3];
        
        // Actions to make fire particles move up, then remove all particles
        //id moveAction = [CCMoveBy actionWithDuration:animationTime position:CGPointMake(0, self.contentSize.height - 5)];
        id pauseAction = [CCDelayTime actionWithDuration:self.animationTime];
        id cleanupAction = [CCCallFuncN actionWithTarget:self selector:@selector(removeDeathParticles)];
        id sequence = [CCSequence actions:pauseAction, cleanupAction, nil];
        [lavaDeathParticles runAction:sequence];
        
        // Fade color of player to black
        id colorChangeAction = [CCTintTo actionWithDuration:self.animationTime red:0 green:0 blue:0];
        [self runAction:colorChangeAction];
    }
    
    // Spike Collision
    if (hazardType == HAZARDTYPESPIKES)
    {
        self.animationTime = 0.15; // Time that the animation will last
        
        // Put character behind spikes and move down
        [self.parent reorderChild:self z:2];
        id movePlayerAction = [CCMoveBy actionWithDuration:self.animationTime position:ccp(0,self.contentSize.height/2)];
        [self runAction:movePlayerAction];
        //id rotatePlayerAction = [CCRotateBy actionWithDuration:self.animationTime angle:90];
        //[self runAction:rotatePlayerAction];
        
        // Add particles at center of body
        CCParticleSystemQuad *bloodSplatterParticles = [CCParticleSystemQuad particleWithFile:@"bloodSplatter.plist"];
        bloodSplatterParticles.position = CGPointZero;
        bloodSplatterParticles.position = ccp(bloodSplatterParticles.position.x + self.contentSize.width/2,
                                              bloodSplatterParticles.position.y + self.contentSize.height);
        bloodSplatterParticles.tag = 1111;
        [self addChild:bloodSplatterParticles z:3];
        
        // Pause then remove particles
        id pauseAction = [CCDelayTime actionWithDuration:self.animationTime + bloodSplatterParticles.lifeVar];
        id cleanupAction = [CCCallFuncN actionWithTarget:self selector:@selector(removeDeathParticles)];
        id sequence = [CCSequence actions:pauseAction, cleanupAction, nil];
        [bloodSplatterParticles runAction:sequence];
    }
}

@end
