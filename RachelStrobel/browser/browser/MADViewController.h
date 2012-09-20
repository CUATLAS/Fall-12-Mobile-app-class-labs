//
//  MADViewController.h
//  browser
//
//  Created by Rachel Strobel on 9/20/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
