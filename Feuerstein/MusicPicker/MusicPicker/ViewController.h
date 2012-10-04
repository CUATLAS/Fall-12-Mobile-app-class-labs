//
//  ViewController.h
//  MusicPicker
//
//  Created by Stephen Feuerstein on 10/4/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *genres;
    NSArray *years;
    
    NSString *yearString;
    NSString *genreString;
}

@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

@end
