//
//  MADViewController.h
//  tipcalculator
//
//  Created by Elise J Beall on 9/18/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UITextFieldDelegate>
- (IBAction)calculate:(id)sender;
- (IBAction)backgroundClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalDuePerPerson;
@property (weak, nonatomic) IBOutlet UILabel *totalDue;
@property (weak, nonatomic) IBOutlet UILabel *tipDue;
@property (weak, nonatomic) IBOutlet UITextField *people;
@property (weak, nonatomic) IBOutlet UITextField *tipPercent;
@property (weak, nonatomic) IBOutlet UITextField *checkAmount;

@end
