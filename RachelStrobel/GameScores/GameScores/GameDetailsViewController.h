//
//  GameDetailsViewController.h
//  GameScores
//
//  Created by Rachel Strobel on 11/8/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameDetailsViewController;
@protocol GameDetailsViewControllerDelegate <NSObject>

-(void) gameDetailsViewControllerDidCancel:
(GameDetailsViewController *) controller;
-(void) gameDetailsViewController: (GameDetailsViewController *)controller DidSave:(NSString*)newGame;

@end

@interface GameDetailsViewController : UITableViewController
@property(weak, nonatomic)id<GameDetailsViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

@end
