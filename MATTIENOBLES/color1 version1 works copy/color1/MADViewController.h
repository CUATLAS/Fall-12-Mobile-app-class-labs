//
//  MADViewController.h
//  color1
//
//  Created by Mattie Nobles on 10/2/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
- (IBAction)colorCombo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *colorMessage;

@end
