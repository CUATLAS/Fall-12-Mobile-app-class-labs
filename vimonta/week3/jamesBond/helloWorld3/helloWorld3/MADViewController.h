//
//  MADViewController.h
//  helloWorld3
//
//  Created by Aaron Vimont on 9/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>
extern bool pierceWasClicked;

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bondImage;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@property (weak, nonatomic) IBOutlet UIButton *pierceBtn;
- (IBAction)chooseBond:(UIButton *)sender;
- (IBAction)reset:(UIButton *)sender;

@end
