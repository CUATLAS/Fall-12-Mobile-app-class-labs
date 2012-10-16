//
//  MADViewController.h
//  musicpicker2
//
//  Created by  on 10/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *musicChoice;
@property (strong, nonatomic) NSArray *genre;
@property (strong, nonatomic) NSArray *decade;
@end
