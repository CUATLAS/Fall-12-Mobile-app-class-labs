//
//  MADSecondViewController.h
//  GameScores
//
//  Created by  on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADSecondViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *gameWeb;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *gameSpinner;



@end


