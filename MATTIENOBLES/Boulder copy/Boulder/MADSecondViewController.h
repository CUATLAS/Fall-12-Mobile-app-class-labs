//
//  MADSecondViewController.h
//  Boulder
//
//  Created by Mattie Nobles on 10/18/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADSecondViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *secondWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *secondSpinner;

@end
