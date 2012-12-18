//
//  MADHomeViewController.h
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADAppDelegate.h"
#import "MADStoredData.h"

#define ARRAYLENGTH 3
#define MOVINGLEFT  0
#define MOVINGRIGHT 1

@interface MADHomeViewController : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *theSegment;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *leftLowValue;
@property (weak, nonatomic) IBOutlet UITextField *leftHighValue;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UITextField *middleLowValue;
@property (weak, nonatomic) IBOutlet UITextField *middleHighValue;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UITextField *rightLowValue;
@property (weak, nonatomic) IBOutlet UITextField *rightHighValue;
@property (weak, nonatomic) IBOutlet UILabel *lowValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *highValueLabel;
@property (weak, nonatomic) IBOutlet UIView *swipeView;
@property (weak, nonatomic) IBOutlet UIButton *showHideButton;
@property (weak, nonatomic) IBOutlet UIButton *showTableButton;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UIImageView *earthImage;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)showTheTable:(UIButton *)sender;
- (IBAction)resetTable:(UIButton *)sender;
- (IBAction)showHideInput:(UIButton *)sender;
- (IBAction)infoButtonTapped:(UIButton *)sender;

- (IBAction)highValueDoneEditing:(UITextField *)sender;
- (IBAction)lowValueDoneEditing:(UITextField *)sender;

@end
