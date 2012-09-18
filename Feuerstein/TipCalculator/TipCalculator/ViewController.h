//
//  ViewController.h
//  TipCalculator
//
//  Created by Stephen Feuerstein on 9/18/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *checkAmountField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentField;
@property (weak, nonatomic) IBOutlet UITextField *numPeopleField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *perPersonLabel;
@end
