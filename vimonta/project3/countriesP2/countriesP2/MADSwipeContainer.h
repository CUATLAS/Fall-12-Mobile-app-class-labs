//
//  MADSwipeContainer.h
//  countriesP2
//
//  Created by Aaron Vimont on 11/2/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADSwipeContainer : NSObject

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UITextField *lowValTextField;
@property (strong, nonatomic) UITextField *highValTextField;

- (void)setAllItems:(UILabel *)newLabel lowText:(UITextField *)lowText highText:(UITextField *)highText;
- (void)moveCenterLabelX:(CGFloat)labelX labelY:(CGFloat)labelY lowValX:(CGFloat)lowValX lowValY:(CGFloat)lowValY highValX:(CGFloat)highValX highValY:(CGFloat)highValY;

@end
