//
//  LABViewController.h
//  Webpage
//
//  Created by new user on 10/8/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LABViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate> // UIViewController reference: View Controller Programming Guide
// Instantiate UIViewController subclasses based on specific task each subclass performs
// Takes part in responder chain used to handle events
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender;

@end
