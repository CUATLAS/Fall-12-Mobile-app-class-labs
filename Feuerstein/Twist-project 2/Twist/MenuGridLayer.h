//
//  MenuGridLayer.h
//  Twist
//
//  Created by Stephen Feuerstein on 10/7/12.
//  Copyright 2012 GingerSnAPPs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"

@interface MenuGridLayer : CCLayer
{
    // Positioning
    CGPoint padding;
    CGPoint originalMenuPos; // Original position of the whole menu
    
    // Menu Pages
    int numberOfPages; // Total number of pages in the menu
    int currentPage;
    
    // Handling touches
    CGPoint touchOriginPoint; // Where touch began
    CGPoint touchEndPoint;
    bool isMoving; // True if the grid is currently moving
    CGRect swipableAreaRect; // CGRect for the area of the screen that will be swipable for moving the menu grid
    float touchMoveDistance; // Distance from touchOriginPoint to touchEndPoint
    float touchMoveNewPageMin; // Minimum touchMoveDistance to move to a new page
    
    CCMenuItem *selectedItem; // Menu item that was selected
    
    float animationSpeed; // 0.0-1.0
    
    UIPageControl *pageControl; // Page indicator
}

+(id)menuGridWithArray:(NSMutableArray *)items columns:(int)numColumns rows:(int)numRow position:(CGPoint)pos padding:(CGPoint)paddingAmount;

-(id)initWithArray:(NSMutableArray *)items columns:(int)numColumns rows:(int)numRows position:(CGPoint)pos padding:(CGPoint)paddingAmount;

@property(nonatomic, assign)BOOL backAreaTouched;

@end
