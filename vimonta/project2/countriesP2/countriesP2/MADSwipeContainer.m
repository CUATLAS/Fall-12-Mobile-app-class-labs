//
//  MADSwipeContainer.m
//  countriesP2
//
//  Created by Aaron Vimont on 11/2/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADSwipeContainer.h"

@implementation MADSwipeContainer

@synthesize title, lowValTextField, highValTextField;

- (void)setAllItems:(UILabel *)newLabel lowText:(UITextField *)lowText highText:(UITextField *)highText {
    [self setTitle:newLabel];
    [self setLowValTextField:lowText];
    [self setHighValTextField:highText];
}

- (void)moveCenterLabelX:(CGFloat)labelX labelY:(CGFloat)labelY lowValX:(CGFloat)lowValX lowValY:(CGFloat)lowValY highValX:(CGFloat)highValX highValY:(CGFloat)highValY {
    title.center = CGPointMake(labelX, labelY);
    lowValTextField.center = CGPointMake(lowValX, lowValY);
    highValTextField.center = CGPointMake(highValX, highValY);
}

@end
