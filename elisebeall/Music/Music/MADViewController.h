//
//  MADViewController.h
//  Music
//
//  Created by Elise J Beall on 10/4/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *youreCool;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (strong, nonatomic) NSArray *genre;
@property (strong, nonatomic) NSArray *decade;

@end
