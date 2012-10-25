//
//  MADViewController.h
//  favorites_RachelStrobel
//
//  Created by Rachel Strobel on 10/11/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h" 

@interface MADViewController : UIViewController{
    Favorite *user; //creates the model object
}
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITextView *quoteText;
- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender;

@end
