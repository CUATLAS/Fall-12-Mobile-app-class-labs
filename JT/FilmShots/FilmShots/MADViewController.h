//
//  MADViewController.h
//  FilmShots
//
//  Created by John Birchall on 9/26/12.
//  Copyright (c) 2012 John Birchall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
- (IBAction)extremeCloseUp:(UIButton *)sender;
- (IBAction)closeUp:(UIButton *)sender;
- (IBAction)meduimShot:(UIButton *)sender;
- (IBAction)longShot:(UIButton *)sender;
- (IBAction)extremeLongShot:(UIButton *)sender;
- (IBAction)dutchShot:(UIButton *)sender;
- (IBAction)pointOfViewShot:(UIButton *)sender;
- (IBAction)shotReverseShot:(UIButton *)sender;
- (IBAction)highAngleShot:(UIButton *)sender;
- (IBAction)lowAngleShot:(UIButton *)sender;
- (IBAction)birdsEyeViewShot:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *shotInformation;
@property (weak, nonatomic) IBOutlet UIImageView *shotExample;

@end
