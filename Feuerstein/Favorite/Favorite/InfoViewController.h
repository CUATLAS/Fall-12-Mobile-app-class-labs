//
//  InfoViewController.h
//  Favorite
//
//  Created by Stephen Feuerstein on 10/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"

@interface InfoViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet UITextView *quoteTextView;
@property (strong, nonatomic)Favorite *userData;
- (IBAction)backButtonTapped:(UIBarButtonItem *)sender;
@end
