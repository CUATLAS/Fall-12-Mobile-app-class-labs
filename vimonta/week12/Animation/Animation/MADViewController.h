//
//  MADViewController.h
//  Animation
//
//  Created by Aaron Vimont on 11/15/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
- (IBAction)sliderMoved:(UISlider *)sender;

@end
