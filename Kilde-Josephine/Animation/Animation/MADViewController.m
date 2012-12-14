//
//  MADViewController.m
//  Animation
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController () {
    CGPoint delta; //Specifies how many points the image must move everytime the timer fires
    NSTimer *timer; //The animation timer
    float ballRadius; //Radius of the ball
    CGPoint translation; //Specifies how many points the image will move
    float angle; //Angle for rotation
}

@end

@implementation MADViewController
@synthesize slider;
@synthesize sliderLabel;
@synthesize imageView;

//Changes the position of the image view
-(void) onTimer
{
    //animation block
	[UIView beginAnimations:@"my_own_animation" context:nil];
	
	[UIView animateWithDuration:slider.value //Animate for the duration of the slider value (time interval)
						  delay:0 //Have the animation start right away
						options:UIViewAnimationCurveLinear //Set the animation curve type
     //Set the animation curve type
					 animations:^{imageView.transform=CGAffineTransformMakeRotation(angle);}
					 completion:NULL];
	
	[UIView commitAnimations];
	
	angle += 0.02; //Amount by which you increment the angle
	//A full rotation of 360 degrees is 2PI radians=6.2857 so you reset the angle
	if (angle>6.2857)
		angle=0;
    
	imageView.center = CGPointMake(imageView.center.x + delta.x, imageView.center.y + delta.y);
	
	//If the image touched the sides of the screen it reverses the direction
	if (imageView.center.x > self.view.bounds.size.width - ballRadius || imageView.center.x < ballRadius)
		delta.x = -delta.x;
	//If the image touched the top or bottom of the screen it reverses the direction
	if (imageView.center.y > self.view.bounds.size.height - ballRadius || imageView.center.y < ballRadius)
		delta.y = -delta.y;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Ball radius is half the width of the image
    ballRadius=imageView.frame.size.width/2;
	//Initialize the delta. tells it to move 12 pixels horizontally, 4 pixels vertically
    delta=CGPointMake(12.0, 4.0);
    translation=CGPointMake(0.0, 0.0);
    angle=0; //sets angle to 0
	[self changeSliderValue];
    
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

-(IBAction)changeSliderValue
{
	sliderLabel.text=[NSString stringWithFormat:@"%.2f", slider.value];
	//Creates a new timer object with the slider's time interval
	timer = [NSTimer scheduledTimerWithTimeInterval:slider.value //Number of seconds between firings of the timer
											 target:self
										   selector:@selector(onTimer) //The message sent when the timer fires
										   userInfo:nil
											repeats:YES]; //Whether or not the timer repeatedly reschedules itself.
	//YES will repeatedly reschedule the timer until invalidated
}
- (IBAction)sliderMoved:(UISlider *)sender {
    [timer invalidate];	//Stops the timer
	//Must invalidate and create a new object to change its firing interval
	[self changeSliderValue];}
@end
