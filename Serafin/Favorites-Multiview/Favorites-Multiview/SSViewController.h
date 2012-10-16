//
//  SSViewController.h
//  Favorites-Multiview
//
//  Created by Scott Serafin on 10/11/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITextView *quoteText;
- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender;

@end
