//
//  InfoViewController.h
//  Favorite
//
//  Created by  on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"

@interface InfoViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate > 
@property (weak, nonatomic) IBOutlet UITextField *userWord;
@property (weak, nonatomic) IBOutlet UITextView *userQuote;
- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;
@property (strong, nonatomic) Favorite *userInfo;
@end
