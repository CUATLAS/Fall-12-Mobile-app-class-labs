//
//  MADViewController.h
//  Control Fun
//
//  Created by James Mason on 9/8/12.
//  Copyright (c) 2012 Trinary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageOnScreen;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelOnScreen;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UIButton *doSomethingButton;

- (IBAction)textFieldDoneEditing:(id)sender;

- (IBAction)backgroundTap:(id)sender;

- (IBAction)sliderChanged:(id)sender;

- (IBAction)switchChanged:(id)sender;

- (IBAction)toggleControls:(id)sender;

- (IBAction)buttonPressed:(id)sender;

@end
