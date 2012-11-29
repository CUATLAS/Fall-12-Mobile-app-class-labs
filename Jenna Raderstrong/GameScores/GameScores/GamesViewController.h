//
//  GamesViewController.h
//  GameScores
//
//  Created by Jenna Raderstrong on 11/6/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamesDetailsViewController.h"
@interface GamesViewController : UITableViewController
<GamesDetailsViewControllerDelegate>
@property(strong, nonatomic) NSMutableArray *games;
@property(strong, nonatomic) NSMutableArray *scores;
@property(copy, nonatomic) NSDictionary *editedSelection;


@end
