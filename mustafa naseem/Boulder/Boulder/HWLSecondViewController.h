//
//  HWLSecondViewController.h
//  Boulder
//
//  Created by  on 10/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWLSecondViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *secondWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *secondSpinner;

@end
