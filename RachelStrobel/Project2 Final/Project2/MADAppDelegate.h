//
//  MADAppDelegate.h
//  Project2
//
//  Created by Rachel Strobel on 10/24/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class MADMexicoViewController, MADMapViewController, MADReportViewController, MADMissingTableViewController, MADMissingViewController, MADInfoViewController;

@interface MADAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IBOutlet UITabBarController *rootController;

@end
