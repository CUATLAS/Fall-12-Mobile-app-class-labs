//
//  ViewController.m
//  Animation
//
//  Created by Stephen Feuerstein on 11/15/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
{
    //CGPoint moveDelta;
    NSTimer *timer;
    float ballRadius;
    CGPoint moveVector;
    float rotationAngle;
    
    int numberOfCollisions;
}

@end

@implementation ViewController
@synthesize ballImageView, slider, sliderLabel;

-(void)changeSliderValue
{
    sliderLabel.text=[NSString stringWithFormat:@"%.2f",slider.value];
    timer = [NSTimer scheduledTimerWithTimeInterval:slider.value
                                             target:self
                                           selector:@selector(timerUpdate)
                                           userInfo:nil repeats:YES];
}

-(void)timerUpdate
{
    // Animation
    [UIView beginAnimations:@"ballAnimation" context:nil];
    // Rotation and movement with 
    [UIView animateWithDuration:slider.value delay:0 options:UIViewAnimationCurveLinear animations:^{ballImageView.transform=CGAffineTransformMakeRotation(rotationAngle);
        ballImageView.center = CGPointMake(ballImageView.center.x + moveVector.x,
                                           ballImageView.center.y + moveVector.y);} completion:NULL];
    [UIView commitAnimations];
    
    rotationAngle += 0.04;
    if (rotationAngle > (2 * M_PI)) // if > full circle, reset
    {
        rotationAngle = 0;
    }
    
    // Move ball image
    //ballImageView.center = CGPointMake(ballImageView.center.x + moveVector.x,
    //                                   ballImageView.center.y + moveVector.y);
    
    // Check for collision with window bounds, and invert velocity
    // Right/Left
    if ((ballImageView.center.x + ballRadius) > self.view.bounds.size.width ||
        ballImageView.center.x < ballRadius)
    {
        moveVector.x = -moveVector.x;
        numberOfCollisions++;
    }
    // Bottom/Top
    if ((ballImageView.center.y + ballRadius) > sliderLabel.center.y ||
        ballImageView.center.y < ballRadius)
    {
        moveVector.y = -moveVector.y;
        numberOfCollisions++;
    }
    
    // Testing tinting
    UIImage *myImage = [UIImage imageNamed:@"tennisball.jpg"];
    UIImage *scaledImage = [UIImage imageWithCGImage:[myImage CGImage] scale:0.1 orientation:UIImageOrientationUp];
    UIView *overlay = [[UIView alloc] initWithFrame:[ballImageView frame]];
    overlay.frame.size = 0.1;
    
    UIImageView *maskImageView = [[UIImageView alloc] initWithImage:scaledImage];
    [maskImageView setFrame:[overlay bounds]];
    
    [[overlay layer] setMask:[maskImageView layer]];
    
    [overlay setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:overlay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    ballRadius = ballImageView.frame.size.width/2;
    moveVector = CGPointMake(9.0, 8.0);
    rotationAngle = 0;
    [self changeSliderValue];
    
    numberOfCollisions = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBallImageView:nil];
    [self setSlider:nil];
    [self setSliderLabel:nil];
    [super viewDidUnload];
}
- (IBAction)sliderValueChanged:(UISlider *)sender
{
    [timer invalidate];
    [self changeSliderValue];
}
@end
