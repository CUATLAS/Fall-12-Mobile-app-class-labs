//
//  GameDetailsViewController.h
//  GameScores
//
//  Created by Aaron Vimont on 11/8/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameDetailsViewController;
@protocol GameDetailsViewControllerDelegate <NSObject>

- (void)gameDetailsViewControllerDidCancel:(GameDetailsViewController *)controller;
- (void)gameDetailsViewController:(GameDetailsViewController *)controller DidSave:(NSString *)newGame WithScore:(NSString *)score;

@end

@interface GameDetailsViewController : UITableViewController
@property (weak, nonatomic) id<GameDetailsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
