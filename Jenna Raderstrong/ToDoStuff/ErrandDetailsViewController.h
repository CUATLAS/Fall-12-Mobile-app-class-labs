//
//  ErrandDetailsViewController.h
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/12/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ErrandDetailsViewController;
@protocol ErrandDetailsViewControllerDelegate <NSObject>
-(void)errandDetailsViewControllerDidCancel:(ErrandDetailsViewController *)controller;
-(void)errandDetailsViewController:(ErrandDetailsViewController *)controller DidSave:(NSString *)newErrand;
@end
@interface ErrandDetailsViewController : UITableViewController
@property(weak, nonatomic)id<ErrandDetailsViewControllerDelegate> delegate;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *errandTextField;
@end

