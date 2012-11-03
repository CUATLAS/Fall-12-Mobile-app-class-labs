//
//  ViewController.h
//  Continents
//
//  Created by Stephen Feuerstein on 10/23/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ViewController : UITableViewController
{
    NSMutableDictionary *continentData;
    DetailViewController *detailVC;
}

@end
