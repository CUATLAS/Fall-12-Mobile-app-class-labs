//
//  SSInfoViewController.h
//  Favorites-Multiview
//
//  Created by Scott Serafin on 10/11/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSFavorite.h"

@interface SSInfoViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *userQuote;
@property (weak, nonatomic) IBOutlet UITextField *userWord;
- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;
@property(strong, nonatomic)SSFavorite *userInfo;

@end
