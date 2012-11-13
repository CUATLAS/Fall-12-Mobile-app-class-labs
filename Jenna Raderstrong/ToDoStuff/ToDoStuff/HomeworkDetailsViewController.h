//
//  HomeworkDetailsViewController.h
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/11/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeworkDetailsViewController;
@protocol HomeworkDetailsViewControllerDelegate <NSObject>
-
(void)homeworkDetailsViewControllerDidCancel:(HomeworkDetailsViewController *)controller;
-(void)homeworkDetailsViewController:(HomeworkDetailsViewController *)controller DidSave:(NSString *)newHomework;
@end
@interface HomeworkDetailsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *homeworkTextField;
@property(weak, nonatomic)id<HomeworkDetailsViewControllerDelegate> delegate;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
@end

