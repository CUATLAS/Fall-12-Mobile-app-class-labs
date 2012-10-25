//
//  InfoViewController.h
//  favorites_RachelStrobel
//
//  Created by Rachel Strobel on 10/11/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"

@interface InfoViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userWord;
@property (weak, nonatomic) IBOutlet UITextView *userQuote;
- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;
@property(strong, nonatomic)Favorite *userInfo;

@end
