//
//  ViewController.h
//  MusicDependent
//
//  Created by Stephen Feuerstein on 10/9/12.
//  Copyright (c) 2012 GingerSnAPPs. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ARTISTCOMPONENT 0
#define ALBUMCOMPONENT 1

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSDictionary *artistAlbumsDict;
    NSArray *artists;
    NSMutableArray *albums;
}

@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *selectionLabel;
@end
