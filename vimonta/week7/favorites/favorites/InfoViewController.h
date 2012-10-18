//
//  InfoViewController.h
//  favorites
//
//  Created by Aaron Vimont on 10/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"

@interface InfoViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userWord;
@property (weak, nonatomic) IBOutlet UITextView *userQuote;
@property (strong, nonatomic) Favorite *userInfo;

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;

@end
