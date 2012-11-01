//
//  MADViewController.m
//  ColorMixer
//
//  Created by Jenna Raderstrong on 9/30/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize picture;
@synthesize color1;
@synthesize color2;


@synthesize titleHeader;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTitleHeader:nil];
    [self setPicture:nil];

    [self setColor1:nil];
    [self setColor2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)chooseColor:(UIButton *)sender {
   
        
    if((color1.text.length)==0){
            switch(sender.tag){
                    
                case 0:
                    color1.text=@"Red";
                    break;

                case 1: color1.text=@"Blue";
                    break;
                case 2: color1.text=@"Yellow";
                    break;
                case 3: color1.text=@"Green";
                    break;
                case 4: color1.text=@"Orange";
                    break;
                case 5: color1.text=@"Purple";
                    break;
            }}
    else if (color1.text.length>0){
            switch(sender.tag){
                    
                case 0: color2.text=@"Red";
                    break;
                case 1: color2.text=@"Blue";
                    break;
                case 2: color2.text=@"Yellow";
                    break;
                case 3: color2.text=@"Green";
                    break;
                case 4: color2.text=@"Orange";
                    break;
                case 5: color2.text=@"Purple";
                    break;
                    
            }}
/*if((color1.text.length>0) && (color2.text.length>0)){
    switch(sender.tag){
            
        case 0:
            color1.text=@"Red";
            break;
            
        case 1: color1.text=@"Blue";
            break;
        case 2: color1.text=@"Yellow";
            break;
        case 3: color1.text=@"Green";
            break;
        case 4: color1.text=@"Orange";
            break;
        case 5: color1.text=@"Purple";
            break;
    }
    color2.text=@"";
    
}*/}


- (IBAction)mixButton:(UIButton *)sender {
    titleHeader.text=@"Here's Your Mixture!";
    if(color1.text==@"Red"){
        if(color2.text==@"Red"){
            [picture setImage:[UIImage imageNamed:@"red.png"]];
        }
        if(color2.text==@"Blue"){
              [picture setImage:[UIImage imageNamed:@"Purple.jpeg"]];
           
        }
        if(color2.text==@"Yellow"){
           [picture setImage:[UIImage imageNamed:@"orange.jpeg"]];
        }
        if(color2.text==@"Green"){
              [picture setImage:[UIImage imageNamed:@"Brown.jpeg"]];
           
        }
       
    }
        
        if(color1.text==@"Blue"){
            if(color2.text==@"Red"){
                 [picture setImage:[UIImage imageNamed:@"Purple.jpeg"]];
            }
            if(color2.text==@"Blue"){
              [picture setImage:[UIImage imageNamed:@"blue.jpeg"]];
            }
            if(color2.text==@"Yellow"){
      [picture setImage:[UIImage imageNamed:@"green.jpeg"]];
            }
            if(color2.text==@"Green"){
                [picture setImage:[UIImage imageNamed:@"bluegreen.gif"]];
            }
           
        }
        if(color1.text==@"Yellow"){
            if(color2.text==@"Red"){
                [picture setImage:[UIImage imageNamed:@"orange.jpeg"]];
            }
            if(color2.text==@"Blue"){
               [picture setImage:[UIImage imageNamed:@"green.jpeg"]];
            }
            if(color2.text==@"Yellow"){
                [picture setImage:[UIImage imageNamed:@"yellow.png"]];
            }
            if(color2.text==@"Green"){
                [picture setImage:[UIImage imageNamed:@"lightgreen.jpeg"]];
            }
            
            
        }
        if(color1.text==@"Green"){
            if(color2.text==@"Red"){
                [picture setImage:[UIImage imageNamed:@"Brown.jpeg"]];
            }
            if(color2.text==@"Blue"){
                [picture setImage:[UIImage imageNamed:@"yellow.png"]];
            }
            if(color2.text==@"Yellow"){
                [picture setImage:[UIImage imageNamed:@"lightgreen.jpeg"]];
            }
            if(color2.text==@"Green"){
                [picture setImage:[UIImage imageNamed:@"green.jpeg"]];
            }
         
        }
        

    }
        
- (IBAction)tryAgain:(UIButton *)sender {
    titleHeader.text=@"Choose two colors you want to mix";
    color1.text=@"";
    color2.text=@"";
      [picture setImage:[UIImage imageNamed:@""]];
    
}
@end
    










