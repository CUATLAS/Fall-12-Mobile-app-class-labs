//
//  LevelMenu.h
//  Twist
//
//  Created by Stephen Feuerstein on 8/30/12.
//  Copyright 2012 GingerSnAPPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelMenu : CCLayer
{
    tCCMenuState state; // CCMenu State
    CCMenuItem *selectedItem; // Item selected by touch
    
    CGPoint padding; // Padding between menu images
    CGPoint anchorOrigin; // Anchorpoint for whole menu
    CGPoint touchStartedPoint;
    CGPoint touchEndedPoint;
    
    int pageCount; // Number of pages in menu
    int currentPage; // Currently selected page
    
    bool isMoving; // YES if grid is moving
    
    float moveDifference; // Distance from touch and current frams
    float moveNewPageAmount; // Amount needed to slide to new page
    float animationSpeed; // 0.0-1.0
}

+(id)menuWithArray:(NSMutableArray *)items cols:(int)cols rows:(int)rows position:(CGPoint)pos padding:(CGPoint)pad;

-(id)initWithArray:(NSMutableArray *)items cols:(int)cols rows:(int)rows position:(CGPoint)pos padding:(CGPoint)pad;

-(void)buildGridWithColumns:(int)cols rows:(int)rows;
-(CCMenuItem *)getItemWithinTouch:(UITouch *)touch;
-(CGPoint)getPositionOfCurrentPageWithOffset:(float)offset;
-(CGPoint)getPositionOfCurrentPage;

-(float)getMoveNewPageAmount;
-(void)setMoveNewPageAmount:(float)value;

@property (nonatomic, readwrite)CGPoint padding;
@property (nonatomic, readwrite)CGPoint anchorOrigin;
@property (nonatomic, readwrite)CGPoint touchStartedPoint;
@property (nonatomic, readwrite)CGPoint touchEndedPoint;
@property (nonatomic, readwrite)int pageCount;
@property (nonatomic, readwrite)int currentPage;
@property (nonatomic, readwrite)bool isMoving;
@property (nonatomic, readwrite)float moveDifference;
@property (nonatomic, readwrite)float moveNewPageAmount;
@property (nonatomic, readwrite)float animationSpeed;

@end
