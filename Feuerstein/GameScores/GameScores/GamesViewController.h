//
//  GamesViewController.h
//  GameScores
//
//  Created by Stephen Feuerstein on 11/6/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDetailsViewController.h"

@interface GamesViewController : UITableViewController<GameDetailsViewControllerDelegate>

@property(strong, nonatomic)NSMutableArray *games;
@property(strong, nonatomic)NSMutableArray *scores;
@property(copy, nonatomic)NSDictionary *editedSelection;

@end
