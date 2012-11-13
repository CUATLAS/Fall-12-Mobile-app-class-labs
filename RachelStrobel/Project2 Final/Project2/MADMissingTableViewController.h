//
//  MADMissingTableViewController.h
//  Project2
//
//  Created by Rachel Strobel on 11/10/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADMissingTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSDictionary *missingPersonData;
@property (strong, nonatomic) NSArray *girls;

@end
