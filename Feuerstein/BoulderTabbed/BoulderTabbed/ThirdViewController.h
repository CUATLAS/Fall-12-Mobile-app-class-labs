//
//  ThirdViewController.h
//  BoulderTabbed
//
//  Created by Stephen Feuerstein on 10/18/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewObject;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerObject;
@end
