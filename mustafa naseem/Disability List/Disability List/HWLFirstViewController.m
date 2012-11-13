//
//  HWLFirstViewController.m
//  Disability List
//
//  Created by  on 11/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLFirstViewController.h"

@interface HWLFirstViewController ()

@end

@implementation HWLFirstViewController
@synthesize landscapeImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (UIInterfaceOrientationPortrait) {
//        
//        UIImage *image = [UIImage imageNamed: @"images.png"];
//        
//        [landscapeImage setImage:image];
//    }
//       
//    if (!UIInterfaceOrientationLandscapeRight || !UIInterfaceOrientationLandscapeLeft) 
//    { UIImage *photo = [UIImage imageNamed:@"blank.png"];
//        [landscapeImage setImage:photo];
//    }
 
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    
}



@end
