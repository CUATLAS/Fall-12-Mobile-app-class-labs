//
//  MoocsListViewController.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoocsWebViewController.h"

@interface MoocsListViewController : UITableViewController

@property (strong, nonatomic)MoocsWebViewController *webViewController;
@property (strong, nonatomic) NSArray *moocs;
@property (strong, nonatomic) id detailItem;

@end
