//
//  MADInfoViewController.h
//  Project2
//
//  Created by Rachel Strobel on 10/24/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADInfoViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *reintegraHome;
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@property (nonatomic) NSInteger pictureCount;
- (IBAction)clickImage:(UIButton *)sender;

@end
