//
//  MADDetailViewController.h
//  Countries2
//
//  Created by Jenna Raderstrong on 10/25/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddText.h"
#import "MADAddViewController.h"

@interface MADDetailViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *countryList;
@property(nonatomic, assign) UIModalTransitionStyle modalTransitionStyle;
@property (strong, nonatomic)MADAddViewController *textInfo;

@end
