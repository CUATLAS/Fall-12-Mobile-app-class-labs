//
//  SSViewController.h
//  Music-Picker-Plist
//
//  Created by Scott Serafin on 10/9/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ARTISTCOMPONENT 0
#define ALBUMCOMPONENT 1

@interface SSViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSDictionary *artistAlbumDictionary;
    NSArray *artists;
    NSArray *albums;
}
@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;

@end
