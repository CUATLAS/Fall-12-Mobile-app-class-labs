//
//  HWLViewController.h
//  Favorite
//
//  Created by  on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"


@interface HWLViewController : UIViewController {
    Favorite *user;
}
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITextView *quoteText;
- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender;

@end
