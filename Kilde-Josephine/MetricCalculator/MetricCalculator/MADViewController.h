//
//  MADViewController.h
//  MetricCalculator
//
//  Created by Rachel Strobel on 10/4/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textEnterNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelAnswer;
@property (weak, nonatomic) IBOutlet UILabel *labelFormula;
- (IBAction)segFormula:(UISegmentedControl *)sender;
- (void)updateFormulaTotals:(NSString *)textToBeConverted forFunctionType:(int)fType;
- (IBAction)milesToKilometers:(UIButton *)sender;
- (IBAction)kilometersToMiles:(UIButton *)sender;
- (IBAction)poundsToKilograms:(UIButton *)sender;
- (IBAction)kilogramsToPounds:(UIButton *)sender;


@end
