//
//  MADViewController.m
//  GizmoNew
//
//  Created by Jenna Raderstrong on 12/6/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//Chipmunk core graphics external library

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize pointsLabel,ball,ballVelocity,sliderBar,highScoreLabel,bg,bg2;
float gravityMagnitude;
float ACCX;
float ACCY;
float flipRotation;
int Points=0;
int ballSize=80;
int highScore=0;

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    ACCX=acceleration.x*10;
    ACCY=acceleration.y*-10;
    flipRotation += 0.1;
    
}
-(void) resetBall{
    ballSize=80;
    ball.center=CGPointMake(100+arc4random() % 100, -100);
    ballVelocity.x=(arc4random() % 10)-5;
    ballVelocity.y=1;
    gravityMagnitude=.05;
    
}
-(void) gameLoop{
    ballVelocity.y=ballVelocity.y+gravityMagnitude;
    ballVelocity.x=ballVelocity.x;
    ball.center = CGPointMake(ball.center.x + ballVelocity.x , ball.center.y + ballVelocity.y);
   sliderBar.center=CGPointMake(sliderBar.center.x+ACCX*3, sliderBar.center.y+ACCY*3);
    if(sliderBar.center.y+5>self.view.bounds.size.height){
        sliderBar.center=CGPointMake(sliderBar.center.x, self.view.bounds.size.height-20);
    }
    if(sliderBar.center.y<100){
        sliderBar.center=CGPointMake(sliderBar.center.x, 100);
    }
    if(sliderBar.center.x+10>self.view.bounds.size.width){
        sliderBar.center=CGPointMake(self.view.bounds.size.width-10, sliderBar.center.y);
    }
    if(sliderBar.center.x<10){
        sliderBar.center=CGPointMake(10, sliderBar.center.y);
    }
    
    //Make sure ball bounces off walls
    if(ball.center.x > self.view.bounds.size.width-10) { //Detect collision with walls of the iPad...
        ball.center = CGPointMake(self.view.bounds.size.width-10, ball.center.y);
        ballVelocity.x = -0.8*ballVelocity.x;
    }
    if(ball.center.x < 10) { //Detect collision with walls of the iPad...
        ball.center = CGPointMake(10, ball.center.y);
        ballVelocity.x = -0.8*ballVelocity.x;
    }
    if(ball.center.y < 10) { //Detect collision with ceiling of iPad.
        ball.center = CGPointMake(ball.center.x, 10);
        ballVelocity.y = -0.8*ballVelocity.y;
    }
    //Slider can only go to 500px, not all the way to the top...
    if(ball.center.y > self.view.bounds.size.height+100) { //Detect collision with 500px from bottom...
        Points=0;
       // [self displayScore];
        [self resetBall];
        return;
    }
    if(ballSize<4){
        [self resetBall];
        return;
    }
    //Detect collision with the ball
    if(ball.center.y > sliderBar.center.y-10) {
        if(ball.center.y < sliderBar.center.y+10) {
            if(ball.center.x > sliderBar.center.x-15) {
                if(ball.center.x < sliderBar.center.x+15 && ball.center.y>8) {
                    ballVelocity.y=-0.9*(ballVelocity.y);
                    ballSize=ballSize*1;
                    Points++;
                    if(Points>highScore){
                        highScore=Points;
                        // [self displayHighScore];
                    }
                    //Points=sqrt((ball.center.x-currentPoint.x)*(ball.center.x-currentPoint.x)+(ball.center.y-15-currentPoint.y)*(ball.center.y-15-currentPoint.y));//This was going to define the ball as a sphere, but I never got it working...
                    // [self displayScore];
                }
            }
        }
    }//end detecting collision with ball

    ball.transform=CGAffineTransformMakeRotation(flipRotation);
    bg.transform= CGAffineTransformMakeRotation(flipRotation);
    bg2.transform= CGAffineTransformMakeRotation(-1*flipRotation);
   
        
   
}
-(void)viewDidLoad {
    [self resetBall];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/3.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];//Start the animation for the ball. Runs every 0.01 seconds for clarity...
    [super viewDidLoad];
    
}
-(void)didReceiveMemoryWarning{
    [self didReceiveMemoryWarning];
}
@end










