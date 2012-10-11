//
//  MADViewController.h
//  musicDependent
//
//  Created by Rachel Strobel on 10/9/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>
#define artistComponent 0
#define albumComponent 1

@interface MADViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> 
@property (weak, nonatomic) IBOutlet UIPickerView *musicPicker;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (strong, nonatomic) NSDictionary *artistAlbums;
@property (strong, nonatomic) NSArray *artists;
@property (strong, nonatomic) NSArray *albums;

@end
