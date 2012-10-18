//
//  MADThirdViewController.h
//  Boulder_News
//
//  Created by Jenna Raderstrong on 10/18/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADThirdViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *thirdWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *thirdSpinner;

@end
