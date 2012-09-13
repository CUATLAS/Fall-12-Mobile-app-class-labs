//
//  ViewController.h
//  HelloWorld3
//
//  Created by Stephen Feuerstein on 9/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)buttonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (nonatomic, assign) BOOL teamChosen;

@end
