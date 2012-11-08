//
//  GamesViewController.h
//  GameScores
//
//  Created by Aaron Vimont on 11/6/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDetailsViewController.h"

@interface GamesViewController : UITableViewController <GameDetailsViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *games;
@property (strong, nonatomic) NSMutableArray *scores;
@property (strong, nonatomic) NSDictionary *editedSelection;

@end
