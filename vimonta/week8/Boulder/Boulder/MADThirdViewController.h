//
//  MADThirdViewController.h
//  Boulder
//
//  Created by Aaron Vimont on 10/18/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADThirdViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *thirdWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *thirdSpinner;

@end
