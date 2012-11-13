//
//  GamesViewController.h
//  GameScores
//
//  Created by Jenna Raderstrong on 11/6/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesViewController : UITableViewController
@property(strong, nonatomic) NSMutableArray *games;
@property(strong, nonatomic) NSMutableArray *scores;
@property(copy, nonatomic) NSDictionary *editedSelection;


@end
