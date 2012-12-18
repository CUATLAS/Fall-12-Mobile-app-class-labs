//
//  MoocsWebViewController.h
//  Sayansi
//
//  Created by Josephine Kilde on 12/15/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MoocsWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *moocsWebView;
@property (strong, nonatomic) id detailItem;

@end
