//
//  MainMenuScene.h
//  Twist
//
//  Created by Stephen Feuerstein on 10/5/12.
//  Copyright 2012 GingerSnAPPs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuGridLayer.h"

@interface MainMenuScene : CCScene {
    MenuGridLayer *menuGrid;
    CCMenu *soundMenu;
}

@end
