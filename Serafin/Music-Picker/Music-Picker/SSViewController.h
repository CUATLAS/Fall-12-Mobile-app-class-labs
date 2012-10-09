//
//  SSViewController.h
//  Music-Picker
//
//  Created by Scott Serafin on 10/4/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSString *genreString;
    NSString *yearString;
}

@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *musicChoice;
@property (strong, nonatomic) NSArray *genre;
@property (strong, nonatomic) NSArray *year;

@end
