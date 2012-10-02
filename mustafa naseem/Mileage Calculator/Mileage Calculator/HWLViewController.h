//
//  HWLViewController.h
//  Mileage Calculator
//
//  Created by  on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWLViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UITextField *initialMileage;
@property (weak, nonatomic) IBOutlet UITextField *currentMileage;
@property (weak, nonatomic) IBOutlet UITextField *cost;
@property (weak, nonatomic) IBOutlet UITextField *gallonsFilled;
@property (weak, nonatomic) IBOutlet UILabel *dollarsPerMile;
@property (weak, nonatomic) IBOutlet UILabel *milesPerGallon;

@end
