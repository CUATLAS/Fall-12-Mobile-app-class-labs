//
//  MADViewController.h
//  helloWorld2
//
//  Created by Aaron Vimont on 9/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
- (IBAction)sayHello:(UIButton *)sender;
- (IBAction)sayGoodbye:(UIButton *)sender;
- (IBAction)shutItDown:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *halsMessage;
@property (weak, nonatomic) IBOutlet UIButton *shutHalDown;

@end
