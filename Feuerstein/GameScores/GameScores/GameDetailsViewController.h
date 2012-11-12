//
//  GameDetailsViewController.h
//  GameScores
//
//  Created by Stephen Feuerstein on 11/8/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameDetailsViewController;
@protocol GameDetailsViewControllerDelegate <NSObject> // Create custom delegate protocol

// Required methods when implementing this delegate
-(void)gameDetailsViewControllerDidCancel:(GameDetailsViewController *)viewController;
-(void)gameDetailsViewController:(GameDetailsViewController *)viewController DidSave:(NSString *)newGame;

@end

@interface GameDetailsViewController : UITableViewController

@property(weak, nonatomic)id<GameDetailsViewControllerDelegate>delegate;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *gameTextField;


@end
