//
//  MADViewController.h
//  Tip_Calculator
//
//  Created by Scott Serafin on 9/18/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Adopts UIText Field Protocol
@interface MADViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

// Variables from XIB
@property (weak, nonatomic) IBOutlet UITextField *check_amount;
@property (weak, nonatomic) IBOutlet UITextField *tip_percent;
@property (weak, nonatomic) IBOutlet UITextField *people;
@property (weak, nonatomic) IBOutlet UILabel *tip_total;
@property (weak, nonatomic) IBOutlet UILabel *bill_total;
@property (weak, nonatomic) IBOutlet UILabel *per_person_total;
- (IBAction)calculate:(id)sender;

@end
