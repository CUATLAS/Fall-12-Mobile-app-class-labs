//
//  MADViewController.h
//  Reintegra_10.1.12
//
//  Created by Rachel Strobel on 10/1/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *reintegraHome;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@property (nonatomic) NSInteger pictureCount;
- (IBAction)clickImage:(UIButton *)sender;


@end
