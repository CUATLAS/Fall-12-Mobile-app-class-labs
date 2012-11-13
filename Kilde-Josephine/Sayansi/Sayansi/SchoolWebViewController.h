//
//  SchoolWebViewController.h
//  Sayansi
//
//  Created by  on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SchoolWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *schoolWebPage;

@property (strong, nonatomic) id detailItem;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;


@end
