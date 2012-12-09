//
//  MADViewController.h
//  GizmoNew
//
//  Created by Jenna Raderstrong on 12/6/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIAccelerometerDelegate> 

@property (retain, nonatomic)IBOutlet UILabel *pointsLabel;
@property (retain, nonatomic)IBOutlet UILabel *highScoreLabel;
@property (nonatomic, retain)IBOutlet UIImageView *ball;
@property (nonatomic, retain)IBOutlet UIImageView *sliderBar;
@property (nonatomic, retain)IBOutlet UIImageView *bg;
@property (nonatomic, retain)IBOutlet UIImageView *bg2;
@property(nonatomic)CGPoint ballVelocity;
@end
