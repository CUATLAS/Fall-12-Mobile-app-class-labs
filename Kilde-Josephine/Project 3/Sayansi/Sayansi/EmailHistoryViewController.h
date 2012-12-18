//
//  EmailHistoryViewController.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/16/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailHistoryViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIWebView *historyWebView;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *emailSpinner;

@end
