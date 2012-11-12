//
//  ScoreViewController.h
//  GameScores
//
//  Created by Stephen Feuerstein on 11/6/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;
@property(strong, nonatomic)NSDictionary *selection;
@property(weak, nonatomic)id delegate;
@end
