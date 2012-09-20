//
//  MADViewController.h
//  browser
//
//  Created by Jenna Raderstrong on 9/20/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender;

@end
