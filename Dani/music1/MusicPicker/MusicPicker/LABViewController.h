//
//  LABViewController.h
//  MusicPicker
//
//  Created by new user on 10/10/12.
//  Copyright (c) 2012 sdocrodrig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LABViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource >
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *musicPicker;
@property(strong, nonatomic) NSArray *genre; 
@end
