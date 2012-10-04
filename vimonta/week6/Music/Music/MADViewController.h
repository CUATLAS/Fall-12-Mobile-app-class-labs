//
//  MADViewController.h
//  Music
//
//  Created by Aaron Vimont on 10/4/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (strong, nonatomic) NSArray *genre;
@property (strong, nonatomic) NSArray *decade;

@end
