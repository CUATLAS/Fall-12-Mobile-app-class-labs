//
//  EmailViewController.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/16/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface EmailViewController : UIViewController <MFMailComposeViewControllerDelegate >

- (IBAction)openMail:(id)sender;
- (IBAction)learnMoreButtonPressed:(UIButton *)sender;


@end
