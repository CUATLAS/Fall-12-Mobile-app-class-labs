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

@class MADMasterViewController;
@interface MADHomeViewController : UIViewController

@property (strong, nonatomic) MADMasterViewController *masterViewController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *theSegment;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *earthImage;

- (IBAction)showTheTable:(UIButton *)sender;
- (IBAction)segmentPressed:(UISegmentedControl *)sender;
- (IBAction)resetTable:(UIButton *)sender;

@end
