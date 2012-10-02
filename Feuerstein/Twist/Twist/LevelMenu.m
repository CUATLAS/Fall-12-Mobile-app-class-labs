//
//  LevelMenu.m
//  Twist
//
//  Created by Stephen Feuerstein on 8/30/12.
//  Copyright 2012 GingerSnAPPS. All rights reserved.
//

#import "LevelMenu.h"


@implementation LevelMenu

@synthesize padding;
@synthesize anchorOrigin;
@synthesize touchStartedPoint;
@synthesize touchEndedPoint;
@synthesize pageCount;
@synthesize currentPage;
@synthesize isMoving;
@synthesize moveDifference;
@synthesize moveNewPageAmount;
@synthesize animationSpeed;

+(id)menuWithArray:(NSMutableArray *)items cols:(int)cols rows:(int)rows position:(CGPoint)pos padding:(CGPoint)pad
{
    return [[[self alloc] initWithArray:items cols:cols rows:rows position:pos padding:pad] autorelease];
}


-(id)initWithArray:(NSMutableArray *)items cols:(int)cols rows:(int)rows position:(CGPoint)pos padding:(CGPoint)pad
{
    if ((self = [super init]))
    {
        self.isTouchEnabled = YES;
        
        // Add items from array as children
        int i = 1;
        for (id item in items)
        {
            [self addChild:item z:i tag:i];
            ++i;
        }
        
        padding = pad;
        currentPage = 0;
        isMoving = NO;
        anchorOrigin = pos;
        moveNewPageAmount = 10;
        animationSpeed = 1.0;
        
        self.position = anchorOrigin;
    }
    return self;
}

-(void)buildGridWithColumns:(int)cols rows:(int)rows
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int col = 0;
    int row = 0;
    
    // Loop through children and set position
    for (CCMenuItem *item in self.children)
    {
        item.position = CGPointMake(self.position.x + (col * padding.x) + (pageCount * winSize.width),
                                    self.position.y - (row * padding.y));
        
        // Increment
        ++col;
        // If at end of columns, go to beginning of next row
        if (col == cols)
        {
            col = 0;
            ++row;
            
            // If at end of max rows, go to new page
            if (row == rows)
            {
                pageCount++;
                col = 0;
                row = 0;
            }
        }
    }
}

// Override of addchild for adding CCMenuItem only
-(void)addchild:(CCMenuItem *)child z:(int)z tag:(int)aTag
{
    return [super addChild:child z:z tag:aTag];
}

-(CCMenuItem *)getItemWithinTouch:(UITouch *)touch
{
    // Get touch location
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    // Iterate through menu items to see if touch was in an item
    for (CCMenuItem *item in [self children])
    {
        CGPoint location = [item convertToNodeSpace:touchLocation];
        
        CGRect itemRect = [item rect];
        itemRect.origin = CGPointZero;
        
        // If touch in item, return item
        if (CGRectContainsPoint(itemRect, location))
            return item;
    }
    return nil;
}

-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Convert touch
    touchStartedPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    // if not in waiting state, return out
    if (state != kCCMenuStateWaiting)
        return NO;
    
    // set selected item if one is touched
    selectedItem = [self getItemWithinTouch:touch];
    [selectedItem selected];
    
    state = kCCMenuStateTrackingTouch;
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    touchEndedPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    moveDifference = (touchEndedPoint.x - touchStartedPoint.x);
    
    // Set position
    [self setPosition:[self getPositionOfCurrentPageWithOffset:moveDifference]];
    isMoving = YES;
}

-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [selectedItem unselected];
    state = kCCMenuStateWaiting;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // If the menu is moving
    if (isMoving)
    {
        isMoving = NO;
        
        // If there are multiple pages and move enough for new page
        if (pageCount > 1 && (moveNewPageAmount < abs(moveDifference)))
        {
            // Sets bool to true if moving forward, false if backward
            bool forward = (moveDifference < 0) ? true : false;
            
            // If there is another page forward
            if (forward && (pageCount > currentPage+1))
            {
                currentPage++;
            }
            
            // If moving backward and we aren't on first page (0)
            else if (!forward && (currentPage > 0))
            {
                currentPage--;
            }
        }
        
        [self moveToCurrentPage];
    }
    
    // Not sliding, just a tap on menu
    else
    {
        [selectedItem unselected];
        [selectedItem activate];
    }
    
    state = kCCMenuStateWaiting;
}

-(void)moveToCurrentPage
{
    //CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    id action = [CCMoveTo actionWithDuration:(animationSpeed*0.5) position:[self getPositionOfCurrentPage]];
    [self runAction:action];
}

-(CGPoint)getPositionOfCurrentPage
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    return (CGPointMake((anchorOrigin.x - (currentPage * winSize.width)), anchorOrigin.y));
}

-(CGPoint)getPositionOfCurrentPageWithOffset:(float)offset
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    return (CGPointMake((anchorOrigin.x - (currentPage * winSize.width) + offset), anchorOrigin.y));
}

-(float)getMoveNewPageAmount
{
    return moveNewPageAmount;
}

-(void)setMoveNewPageAmount:(float)value
{
    moveNewPageAmount = value;
}

-(void)dealloc
{
    [super dealloc];
}

@end
