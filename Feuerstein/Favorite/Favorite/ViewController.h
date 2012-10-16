//
//  ViewController.h
//  Favorite
//
//  Created by Stephen Feuerstein on 10/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"

@interface ViewController : UIViewController
{
    Favorite *userData;
}

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITextView *quoteTextView;
- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender;
@end
