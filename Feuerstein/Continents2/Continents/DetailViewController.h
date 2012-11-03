//
//  DetailViewController.h
//  Continents
//
//  Created by Stephen Feuerstein on 10/30/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController <UITextFieldDelegate>
{
    NSString *cellLabelText;
}

@property (strong, nonatomic)NSMutableArray *countryList;
@end
