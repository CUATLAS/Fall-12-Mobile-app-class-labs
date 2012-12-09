//
//  MADViewController.m
//  Animation
//
//  Created by  on 11/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController () {
    CGPoint Delta; //specifies how many pooints the image must move everytime the timer fires
    NSTimer *timer; //the animation timer
    float ballRadius; //radius of the ball
    CGPoint translation; //specifies how many points the image will move
    float angle;
}

@end

@implementation MADViewController
@synthesize slider;
@synthesize sliderLabel;
@synthesize imageView;


-(IBAction)changesSliderValue {
    sliderLabel.text=[NSString stringWithFormat:@"%.2f", slider.value];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:slider.value //number of seconds between firings of the timer
             
                                             target:self 
                                           selector:@selector(onTimer) //the message sent when the timer fires
                                           userInfo:nil 
                                            repeats:YES]; //whether or not the timer repeatedly reschedules itself. //YES will repeatedly reschedule the timer until invalidated
    
}

-(void) onTimer 
{
    //first animation 
    
    //changes the position by setting a new center of the image view
   // imageView.center= CGPointMake(imageView.center.x + Delta.x, imageView.center.y+Delta.y);
    //if the image touched the sides of the screen, it reverses direction 
//    
//    if (imageView.center.x > self.view.bounds.size.width - ballRadius || imageView.center.x < ballRadius ) 
//        Delta.x = -Delta.x;
//    
//    if (imageView.center.y > self.view.bounds.size.height - ballRadius || imageView.center.y < ballRadius) 
//        Delta.y = -Delta.y; 
    
    
    //second animation
    
//    [UIView beginAnimations:@"my_own_animation" context:nil];
//    [UIView animateWithDuration:slider.value 
//                          delay:0
//                          options:UIViewAnimationCurveLinear 
//                          animations:^{imageView.center = CGPointMake(imageView.center.x + Delta.x, imageView.center.y + Delta.y);} 
//                          completion:NULL];
//    
//    [UIView commitAnimations];
//    
//        if (imageView.center.x > self.view.bounds.size.width - ballRadius || imageView.center.x < ballRadius ) 
//            Delta.x = -Delta.x;
//        
//        if (imageView.center.y > self.view.bounds.size.height - ballRadius || imageView.center.y < ballRadius) 
//            Delta.y = -Delta.y; 
    
    //third animation 
    
//    
//    
//    [UIView beginAnimations:@"my_own_animation" context:nil];
//    [UIView animateWithDuration:slider.value 
//                          delay:0
//                        options:UIViewAnimationCurveLinear 
//                     animations:^{imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);} 
//                     completion:NULL];
//    
//    [UIView commitAnimations];
//    
//    translation.x += Delta.x;
//    translation.y += Delta.y;
//    
//    if (imageView.center.x + translation.x > self.view.bounds.size.width - ballRadius || imageView.center.x + translation.x < ballRadius ) 
//        Delta.x = -Delta.x;
//    
//    if (imageView.center.y + translation.y > self.view.bounds.size.height - ballRadius || imageView.center.y  + translation.y < ballRadius) 
//        Delta.y = -Delta.y; 

    //fourth transformation
    
    [UIView beginAnimations:@"my_own_animation" context:nil];
    [UIView animateWithDuration:slider.value 
                          delay:0
                        options:UIViewAnimationCurveLinear 
                     animations:^{imageView.transform = CGAffineTransformMakeRotation(angle);}
                     completion:NULL];
    
    [UIView commitAnimations];
    
   
    angle += 0.02; 
    if (angle>2*M_PI)
        angle=0;
    imageView.center = CGPointMake (imageView.center.x + Delta.x, imageView.center.y + Delta.y);
    
    if (imageView.center.x > self.view.bounds.size.width - ballRadius || imageView.center.x < ballRadius ) 
        Delta.x = -Delta.x;
    
    if (imageView.center.y > self.view.bounds.size.height - ballRadius || imageView.center.y  < ballRadius) 
        Delta.y = -Delta.y; 
    
    //fifth transformation: look at notes and add it here. 
    
}

- (IBAction)sliderMoved:(UISlider *)sender {
    [timer invalidate];
    [self changesSliderValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ballRadius=imageView.frame.size.width/2; 
    
    Delta=CGPointMake(12.0, 4.0);
    [self changesSliderValue];
    translation= CGPointMake(0.0, 0.0);
    angle = 0;
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
