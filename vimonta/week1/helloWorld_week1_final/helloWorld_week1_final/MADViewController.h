//
//  MADViewController.h
//  helloWorld_week1_final
//
//  Created by Aaron Vimont on 9/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
- (IBAction)buttonClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageField;

@end
