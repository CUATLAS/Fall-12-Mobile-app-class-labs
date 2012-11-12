//
//  MenuGridLayer.m
//  Twist
//
//  Created by Stephen Feuerstein on 10/7/12.
//  Copyright 2012 GingerSnAPPs. All rights reserved.
//

#import "MenuGridLayer.h"

#define MENUGRIDITEMWIDTH 60
#define MENUGRIDITEMHEIGHT 80

@implementation MenuGridLayer
@synthesize backAreaTouched;

+(id)menuGridWithArray:(NSMutableArray *)items columns:(int)numColumns rows:(int)numRows position:(CGPoint)pos padding:(CGPoint)paddingAmount
{
    return ([[[self alloc] initWithArray:items columns:numColumns rows:numRows position:pos padding:paddingAmount] autorelease]);
}

-(BOOL)levelIsLocked:(int)levelNum
{
    if (levelNum <= [GameData sharedGameData].levelsUnlocked)
    {
        return NO;
    }
    else
        return YES;
}

-(void)buildGridWithColumns:(int)numColumns rows:(int)numRows
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int column = 0;
    int row = 0;
    
    // Loop through and add items in grid
    for (CCMenuItem *item in self.children)
    {
        // numberOfPages or currentPage?
        item.position = CGPointMake(self.position.x + (column * padding.x) + (numberOfPages * winSize.width),
                                    self.position.y - (row * padding.y));
        
        ++column;
        if (column == numColumns)
        {
            column = 0;
            ++row;
            
            if (row == numRows)
            {
                numberOfPages++; // Items don't fit on this page, add page
                column = 0;
                row = 0;
            }
        }
    }
    
    // Add level number labels
    for (CCMenuItem *item in self.children)
    {
        CCLabelTTF *itemLabelBG = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%d", item.tag] fontName:@"CreativeBlockBB" fontSize:25];
        CCLabelTTF *itemLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%d", item.tag] fontName:@"CreativeBlockBB" fontSize:25];
        
        itemLabelBG.color = ccc3(0, 0, 0);
        
        if ([self levelIsLocked:item.tag])
        {
            itemLabel.color = ccc3(255, 0, 0); // RED
        }
        else
        {
            itemLabel.color = ccc3(255, 255, 255); // WHITE
        }
        
        itemLabelBG.position = CGPointZero;
        itemLabelBG.position = ccpAdd(itemLabel.position, CGPointMake(MENUGRIDITEMWIDTH/2 + 1, MENUGRIDITEMHEIGHT/2 + 1));
        itemLabel.position = CGPointZero;
        itemLabel.position = ccpAdd(itemLabel.position, CGPointMake(MENUGRIDITEMWIDTH/2, MENUGRIDITEMHEIGHT/2));
        
        if (![self levelIsLocked:item.tag])
        {
            [item addChild:itemLabelBG z:2];
            [item addChild:itemLabel z:3];
        }
    }
    
    // Add Page Indicator
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0,winSize.height - 25,winSize.width,15);
    pageControl.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:100];
    //pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255 green:100 blue:0 alpha:255];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.numberOfPages = numberOfPages + 1;
    pageControl.currentPage = currentPage; 
    pageControl.hidesForSinglePage = NO; // change to yes
    
    [[[CCDirector sharedDirector] view] addSubview:pageControl];
}

-(CCMenuItem *)getItemWithinTouch:(UITouch *)touch
{
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    for (CCMenuItem *item in self.children)
    {
        CGPoint touchPoint = [item convertToNodeSpace:touchLocation];
        
        CGRect itemRect;
        if (item.tag < 100)
        {
            itemRect = [item rect];
            itemRect.origin = CGPointZero;
        
        // If touch in item's rect
            if (CGRectContainsPoint(itemRect, touchPoint))
            {
                return item;
            }
        }
    }
    
    // No item touched
    return nil;
}

-(CGPoint)getPositionOfCurrentPage
// Gets the position of currentPage after movement
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    return (CGPointMake(originalMenuPos.x - (currentPage * winSize.width), originalMenuPos.y));
}

-(CGPoint)getPositionOfCurrentPageWithOffset:(float)offset
// Gets the position of currentPage while moving
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    return (CGPointMake(originalMenuPos.x - (currentPage * winSize.width) + offset, originalMenuPos.y));
}

-(void)updatePageIndicator
{
    // Update page control
    pageControl.currentPage = currentPage;
}

-(void)moveToCurrentPage
// Slides the menu grid to the current page after movement
{
    id moveAction = [CCMoveTo actionWithDuration:(animationSpeed * 0.5) position:[self getPositionOfCurrentPage]];
    id updatePage = [CCCallFuncN actionWithTarget:self selector:@selector(updatePageIndicator)];
    id actionSequence = [CCSequence actionOne:moveAction two:updatePage];
    
    [self runAction:actionSequence];
}

-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:NO];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGRect backAreaRect = CGRectMake(0, 0, 125, 60);
    
    // Converted touch stored as began point
    touchOriginPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    // Set selected item if touch was within an item
    selectedItem = [self getItemWithinTouch:touch];
    [selectedItem selected];
    
    if (CGRectIntersectsRect(backAreaRect, CGRectMake(touchOriginPoint.x, touchOriginPoint.y, 1, 1)))
    {
        NSLog(@"Touch in Back Area");
        backAreaTouched = YES;
        return NO;
    }
    
    backAreaTouched = NO;
    // Touch tracking check if touch in swipable rect?
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if (touchOriginPoint.y > winSize.height - 155 && touchOriginPoint.x < winSize.width/2)
        return;
    
    touchEndPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    touchMoveDistance = (touchEndPoint.x - touchOriginPoint.x);
    
    // Set position of grid
    [self setPosition:[self getPositionOfCurrentPageWithOffset:touchMoveDistance]];
    isMoving = YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    backAreaTouched = NO;
    if (isMoving)
    {        
        isMoving = NO;
        
        // Check for multiple pages and touch movement being enough to increment page
        if (numberOfPages > 0 && touchMoveNewPageMin < abs(touchMoveDistance))
        {
            // Check if moving forward
            bool movingForward = (touchMoveDistance < 0) ? YES : NO;
            
            // Check for available page in move direction
            if (movingForward && numberOfPages > currentPage) // +1
            {
                currentPage++;
            }
            else if (!movingForward && currentPage > 0)
            {
                currentPage--;
            }
        }
        [self moveToCurrentPage];
    }
    
    // Not moving, just tapped the screen
    else
    {
        [selectedItem unselected];
        [selectedItem activate];
    }
}

-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [selectedItem unselected];
}

-(id)initWithArray:(NSMutableArray *)items columns:(int)numColumns rows:(int)numRows position:(CGPoint)pos padding:(CGPoint)paddingAmount
{
    if ((self = [super init]))
    {
        self.isTouchEnabled = YES;
        backAreaTouched = NO;
        
        // Add as children with z:2
        int tagNum = 1;
        for (id item in items)
        {            
            [self addChild:item z:2 tag:tagNum];
            ++tagNum;
        }
        
        padding = paddingAmount;
        currentPage = 0;
        isMoving = false;
        originalMenuPos = pos;
        touchMoveNewPageMin = 10;
        animationSpeed = 1;
        numberOfPages = 0;
        
        [self buildGridWithColumns:numColumns rows:numRows];
        self.position = originalMenuPos;
    }
    return self;
}

@end
