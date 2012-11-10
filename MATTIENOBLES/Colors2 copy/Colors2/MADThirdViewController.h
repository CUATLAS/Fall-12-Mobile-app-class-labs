//
//  MADThirdViewController.h
//  Colors2
//
//  Created by Mattie Nobles on 11/4/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADThirdViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *thirdWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *thirdSpinner;

@end
