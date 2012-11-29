//
//  GamesDetailsViewController.h
//  GameScores
//
//  Created by Jenna Raderstrong on 11/27/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GamesDetailsViewController;
@protocol GamesDetailsViewControllerDelegate <NSObject>
-(void)gamesDetailsViewControllerDidCancel:(GamesDetailsViewController *)controller;
-(void)gamesDetailsViewController:(GamesDetailsViewController *)controller DidSave:(NSString *)newGame;
@end
@interface GamesDetailsViewController : UITableViewController
@property(weak, nonatomic)id<GamesDetailsViewControllerDelegate> delegate;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@end