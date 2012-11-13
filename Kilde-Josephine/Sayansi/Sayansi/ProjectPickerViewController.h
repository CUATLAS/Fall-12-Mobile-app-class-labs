//
//  ProjectPickerViewController.h
//  Sayansi
//
//  Created by  on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *projectPicker;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;

@property (strong, nonatomic) NSArray *subject;
@property (strong, nonatomic) NSArray *project;

@end
