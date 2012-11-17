//
//  metricCalcViewController.h
//  Sayansi
//
//  Created by  on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface metricCalcViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *enterNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *formulaLabel;

- (IBAction)segControlFormula:(UISegmentedControl *)sender;
-(void)updateFormulaTotals:(NSString *)textToBeConverted forFunctionType:(int)fType;

- (IBAction)miToKmButton:(UIButton *)sender;
- (IBAction)kmToMiButton:(UIButton *)sender;
- (IBAction)lbToKgButton:(UIButton *)sender;
- (IBAction)kgToLbButton:(UIButton *)sender;

@end
