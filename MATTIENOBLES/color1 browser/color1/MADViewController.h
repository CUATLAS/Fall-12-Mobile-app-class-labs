//
//  MADViewController.h
//  color1
//
//  Created by Mattie Nobles on 10/2/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
- (IBAction)colorCombo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *colorMessage;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender;


@end
