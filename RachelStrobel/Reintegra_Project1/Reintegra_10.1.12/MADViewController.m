//
//  MADViewController.m
//  Reintegra_10.1.12
//
//  Created by Rachel Strobel on 10/1/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize reintegraHome;
@synthesize messageField;
@synthesize pictureCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
    pictureCount=0;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMessageField:nil];
    [self setReintegraHome:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) viewWillAppear:(BOOL)animated{

}

//all images were taken from Fundacion Reintegra A.C.'s Facebook Page and modified in photoshop at: https://www.facebook.com/FundacionReintegraAC?fref=ts

- (void)chooseImage {
    if (pictureCount == 0) {
    reintegraHome.image = [UIImage imageNamed:@"0.jpg"];
        messageField.text=@"Reintegra is a civil association dedicated to rescuing and rehabilitating survivors of sexual human trafficking.";
    }
    else if (pictureCount == 1) {
        reintegraHome.image = [UIImage imageNamed:@"1.jpg"];
        messageField.text = @"Reintegra helps to educate and raise awareness about human trafficking.";
    }
    else if (pictureCount == 2) {
        reintegraHome.image = [UIImage imageNamed:@"2.jpg"];
        messageField.text = @"Reintegra helps to find victims. Monica was taken in 2004 and is still missing. Help us find her.";
    }
    else if (pictureCount == 3) {
        reintegraHome.image = [UIImage imageNamed:@"3.jpg"];
        messageField.text = @"Reintegra helps prosecute traffickers like Navarrete and Perez  who trafficked three minors ages 14, 14, and 16. ";
    }
    else if (pictureCount == 4) {
        reintegraHome.image = [UIImage imageNamed:@"4.jpg"];
        messageField.text = @"Reintegra helps reintegrate and restore victims. New shoes of an 11 year old survivor.";
    }
    
    else if (pictureCount == 5) {
        reintegraHome.image = [UIImage imageNamed:@"5.jpg"];
        messageField.text = @"Reintegra helps to raise awareness and funds for survivors. Join our hummingbird campaign and tweet #beautyisfreedom.";
    }
                             
    else if (pictureCount == 6) {
            reintegraHome.image = [UIImage imageNamed:@"6.jpg"];
            messageField.text = @"To contact or donate to reintegra, visit the links referenced above.";
    }
                             }

- (IBAction)clickImage:(UIButton *)sender {
    if(sender.tag == 1){
        pictureCount += 1;
        // check to make sure pictureCount is not larger than number of pictures, this is so the user does click next past the number of pictures I have
        if (pictureCount > 6) {
            pictureCount = 6;
        }
        [self chooseImage];
        //reintegraHome.image = [UIImage imageNamed:@"0.jpg"];
    } else {
        pictureCount -= 1;
        // check to make sure picture count does not go less than 0, this is so the user does not click previous in the negative
        if (pictureCount < 0) {
            pictureCount = 0;
        }
        [self chooseImage];
    }
}
@end

