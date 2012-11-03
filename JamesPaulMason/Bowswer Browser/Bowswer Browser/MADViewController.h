//
//  MADViewController.h
//  Bowswer Browser
//
//  Created by James Mason on 9/25/12.
//  Copyright (c) 2012 Trinary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)bookmarksButtonTapped:(id)sender;


@end
