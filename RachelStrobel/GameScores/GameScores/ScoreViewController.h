//
//  ScoreViewController.h
//  GameScores
//
//  Created by Rachel Strobel on 11/6/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;
@property (strong, nonatomic) NSDictionary *selection;
@property (weak, nonatomic) id delegate;

@end
