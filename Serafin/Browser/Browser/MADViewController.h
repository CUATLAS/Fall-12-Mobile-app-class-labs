//
//  MADViewController.h
//  Browser
//
//  Created by Scott Serafin on 9/20/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)bookmarks:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *status;

@end
