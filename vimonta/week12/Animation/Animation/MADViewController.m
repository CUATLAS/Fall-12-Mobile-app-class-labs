//
//  MADViewController.m
//  Animation
//
//  Created by Aaron Vimont on 11/15/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController () {
    CGPoint delta; // specifies how many points the image must move every time the timer fires
    NSTimer *timer; // the animation timer
    float ballRadius; // radius of the ball
    CGPoint translation; // specifies how many points the image would move
    float angle;
}

@end

@implementation MADViewController
@synthesize imageView;
@synthesize slider;
@synthesize sliderLabel;

// updates the timer and label with the current slider value
- (IBAction)changeSliderValue {
    sliderLabel.text = [NSString stringWithFormat:@"%.2f", slider.value];
    
    // create new timer object with the slider's time interval
    timer = [NSTimer scheduledTimerWithTimeInterval:slider.value
                                             target:self
                                           selector:@selector(onTimer)
                                           userInfo:nil
                                            repeats:YES];
}

// changes the position of the image view
- (void)onTimer {
    // change the position by setting a new center of the image view
    //imageView.center = CGPointMake(imageView.center.x + delta.x, imageView.center.y + delta.y);
    [UIView beginAnimations:@"my_own_animation" context:nil];
    [UIView animateWithDuration:slider.value
                          delay:0 options:UIViewAnimationCurveLinear
                     animations:^{
                         //imageView.center = CGPointMake(imageView.center.x + delta.x, imageView.center.y + delta.y);
                         //imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
                         imageView.transform = CGAffineTransformMakeRotation(angle);
                     }
                     completion:NULL];
    [UIView commitAnimations];
    //translation.x += delta.x;
    //translation.y += delta.y;
    angle += 0.2;
    if (angle > 2*M_PI) {
        angle = 0;
    }
    
    imageView.center = CGPointMake(imageView.center.x + delta.x, imageView.center.y + delta.y);
    
    // if the image touched the sides of the screen, it reverses the direction
    if ((imageView.center.x > (self.view.bounds.size.width - ballRadius)) || (imageView.center.x < ballRadius)) {
    //if (((imageView.center.x + translation.x) > (self.view.bounds.size.width - ballRadius)) || ((imageView.center.x + translation.x) < ballRadius)) {
        delta.x = -delta.x;
    }
    
    // if the image touched the top or bottom of the scree, reverse its direction
    if ((imageView.center.y > (self.view.bounds.size.height - ballRadius)) || (imageView.center.y < ballRadius)) {
    //if (((imageView.center.y + translation.y) > (self.view.bounds.size.height - ballRadius)) || ((imageView.center.y + translation.y) < ballRadius)) {
        delta.y = -delta.y;
    }
}

- (IBAction)sliderMoved:(UISlider *)sender {
    [timer invalidate]; // stop the timer. Must invalidate and create a new object to change its firing interval
    [self changeSliderValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // ball radius is half of the width of the image
    ballRadius = imageView.frame.size.width/2;
    
    // initialize the delta. tells it to move 12 points horizontally, 4 points vertically
    delta = CGPointMake(12.0, 4.0);
    translation = CGPointMake(0.0, 0.0);
    angle = 0.0;
    
    [self changeSliderValue];
}

- (void)viewDidUnload
{
    [self setSlider:nil];
    [self setSliderLabel:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
