//
//  MADViewController.h
//  Scrapbook
//
//  Created by Elise J Beall on 10/4/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeTextColor;
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeBGColor;
- (IBAction)textFieldDoneEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageControl1;
- (IBAction)textColor:(UISegmentedControl *)sender;
- (IBAction)backgroundColor:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITextView *textField;
- (IBAction)photoChange2:(UISegmentedControl *)sender;
- (IBAction)photoChange1:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end
