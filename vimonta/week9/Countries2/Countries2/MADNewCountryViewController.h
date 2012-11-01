//
//  MADNewCountryViewController.h
//  Countries2
//
//  Created by Aaron Vimont on 10/30/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADSavedCountry.h"

@interface MADNewCountryViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *theNewCountryName;
@property (strong, nonatomic) MADSavedCountry *countryInfo;

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;


@end
