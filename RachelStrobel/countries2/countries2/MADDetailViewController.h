//
//  MADDetailViewController.h
//  countries2
//
//  Created by Rachel Strobel on 10/25/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADDetailViewController : UITableViewController
@property(strong, nonatomic)NSMutableArray *countryList;
//should not use a delegate here because it is inherited but with the UIViewController, you do need to have the delegate in the .h file

@end
