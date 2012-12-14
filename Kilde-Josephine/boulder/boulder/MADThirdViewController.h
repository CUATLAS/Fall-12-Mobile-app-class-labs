//
//  MADThirdViewController.h
//  boulder
//
//  Created by Josephine Kilde on 12/14/12.
//
//

#import <UIKit/UIKit.h>

@interface MADThirdViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *cuWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cuSpinner;

@end
