//
//  infoViewController.h
//  Favorites
//
//  Created by  on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface infoViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userWord;
@property (weak, nonatomic) IBOutlet UITextView *userQuote;
- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;

@end
