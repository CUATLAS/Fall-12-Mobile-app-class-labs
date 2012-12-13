//
//  ViewController.h
//  Task
//
//  Created by Stephen Feuerstein on 12/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *task1;
@property (weak, nonatomic) IBOutlet UITextField *task2;
@property (weak, nonatomic) IBOutlet UITextField *task3;
@property (weak, nonatomic) IBOutlet UITextField *task4;

-(NSString *)dataFilePath;

@end
