//
//  MasterViewController.h
//  Presidents
//
//  Created by Stephen Feuerstein on 11/1/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController
{
    NSArray *presidents;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
