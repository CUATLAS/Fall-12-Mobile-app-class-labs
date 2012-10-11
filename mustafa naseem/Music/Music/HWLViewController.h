//
//  HWLViewController.h
//  Music
//
//  Created by  on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWLViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource >
@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (strong, nonatomic) NSArray *genre;
@property (strong, nonatomic) NSArray *decade;
@end
