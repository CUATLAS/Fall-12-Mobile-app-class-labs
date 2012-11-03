//
//  MADViewController.h
//  music
//
//  Created by Chris Giersch on 10/4/12.
//  Copyright (c) 2012 Chris Giersch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *trickPicker;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (strong, nonatomic) NSArray *trick; // genre (In Class)
@property (strong, nonatomic) NSArray *penalty;

@end
