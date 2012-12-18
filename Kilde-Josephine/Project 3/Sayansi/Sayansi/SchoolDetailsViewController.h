//
//  SchoolDetailsViewController.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SchoolDetailsViewController;

@protocol SchoolDetailsViewControllerDelegate <NSObject> 

-(void)schoolDetailsViewControllerDidCancel:(SchoolDetailsViewController *)controller;
-(void)schoolDetailsViewController:(SchoolDetailsViewController *)controller
                           DidSave:(NSString *)newSchool;
@end

@interface SchoolDetailsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property(weak, nonatomic)id<SchoolDetailsViewControllerDelegate> delegate;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addSchoolTextField;


@end
