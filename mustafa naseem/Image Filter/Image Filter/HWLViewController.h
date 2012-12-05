//
//  HWLViewController.h
//  Image Filter
//
//  Created by  on 12/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>

@interface HWLViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate > 


@property (weak, nonatomic) IBOutlet UIImageView *imgV;
- (IBAction)changeValue:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *amountSlider;
- (IBAction)loadPhoto:(id)sender;

- (IBAction)savePhoto:(id)sender;
@end
