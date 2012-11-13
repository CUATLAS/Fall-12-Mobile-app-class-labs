//
//  MADMapViewController.h
//  Project2
//
//  Created by Rachel Strobel on 10/25/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADMapViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mapWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mapSpinner;

@end
