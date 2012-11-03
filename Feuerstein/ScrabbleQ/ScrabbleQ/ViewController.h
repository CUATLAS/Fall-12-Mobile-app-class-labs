//
//  ViewController.h
//  ScrabbleQ
//
//  Created by Stephen Feuerstein on 10/23/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *wordsDict;
    NSArray *letters;
}

@end
