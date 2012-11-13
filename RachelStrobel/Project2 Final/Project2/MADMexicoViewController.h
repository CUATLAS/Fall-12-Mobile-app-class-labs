//
//  MADMexicoViewController.h
//  Project2
//
//  Created by Rachel Strobel on 11/8/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>
#define stateComponent 0
#define valueComponent 1

@interface MADMexicoViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> 
@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (strong, nonatomic) NSDictionary *mexico;
@property (strong, nonatomic) NSArray *states;
@property (strong, nonatomic) NSArray *values;

@end
