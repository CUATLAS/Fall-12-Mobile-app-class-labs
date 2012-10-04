//
//  MADViewController.h
//  GNAR2
//
//  Created by Chris Giersch on 10/2/12.
//  Copyright (c) 2012 Chris Giersch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
// Point total
@property (weak, nonatomic) IBOutlet UILabel *pointTotalLabel;

// Butt-Naked Points
@property (weak, nonatomic) IBOutlet UISegmentedControl *nakedSexControl;
- (IBAction)updateNakedPoints:(UISegmentedControl *)sender;

// Cliff-Drop Points
@property (weak, nonatomic) IBOutlet UISegmentedControl *cliffDropControl;
- (IBAction)updateCliffPoints:(UISegmentedControl *)sender;

// Ride-out-an-Avalanche Points
@property (weak, nonatomic) IBOutlet UISwitch *avalancheSwitch;
- (IBAction)updateAvalanchePoints:(UISwitch *)sender;

// Buried-by-an-Avalanche Points
@property (weak, nonatomic) IBOutlet UISwitch *buriedSwitch;
- (IBAction)updateBuriedPoints:(id)sender;

// Day-ending-Injury Points
@property (weak, nonatomic) IBOutlet UISwitch *injurySwitch;
- (IBAction)updateInjuryPoints:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webview;
//@property(nonatomic, getter=isHidden) BOOL hidden;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)bookmarkItemTapped:(UIBarButtonItem *)sender;

@end
