//
//  MADViewController.m
//  Scrapbook
//
//  Created by Elise J Beall on 10/4/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateImage1{
    if (_imageControl1.selectedSegmentIndex==0) {
        _textField.text=@"I had a doctor's appointment on July 3rd, 2007, where I was told that it was time to go to the hospital.  Aiden wasn't due until the 19th, but I had been working too much, and the stress of moving had made it unsafe for him to stay where he was.  With lots of rushing around, we got to the hospital, spent the night, and at 4:28pm on July 4th, 2007, Aiden Christopher Goeken was born!";
		_photo.image=[UIImage imageNamed:@"birth.png"];
    } else if (_imageControl1.selectedSegmentIndex==1) {
        _textField.text=@"From the day Aiden was born, he was surrounded by dogs.  Jack, Louie, and Quincy were a constant source of entertainment while he was learning to crawl.  Their soft ears, slobbery tounges, and silly noises kept him alert and happy.  Early on, he learned to roll the tennis balls across the floor and would giggle when they brought them back to him.";
		_photo.image=[UIImage imageNamed:@"animals.png"];
    } else if (_imageControl1.selectedSegmentIndex==2) {
        _textField.text=@"Aiden loved to play in the snow, and there was plenty of it living at 8,228 feet above sea level!  It was so windy in Nederland, that there were huge drifts over the fence that our dogs Jack and Louie used to escape.  Aiden and I spent quite a lot of time chasing dogs through downtown Nederland.";
        _photo.image=[UIImage imageNamed:@"snow.png"];
    } else if (_imageControl1.selectedSegmentIndex==3) {
        _textField.text=@"Two days before Aiden was born, we moved to Nederland, and so much of the first year, we spent wandering around out in nature.  There were hiking paths around the reservoir, and up into the Indian Peaks Wilderness that we explored often, but almost daily, we walked on a trail that followed a creek next to our house.  Aiden loved to see the birds and squirrels and to hear all of the sounds that came from the mountains.";
        _photo.image=[UIImage imageNamed:@"hike.png"];
    }
}

-(void)updateImage2{
    if (_imageControl2.selectedSegmentIndex==0) {
        _textField.text=@"While I was pregnant with Aiden, I continued to see a lot of live music.  By the time he had arrived, he had at least 10 shows under his belt, and in the first year went to Red Rocks twice, and Rothbury for his first birthday.  His dad and I always played music at home and in the car, and his 'boppa' is a musician who started him out early messing around on the piano, guitar, and even drums.";
        _photo.image=[UIImage imageNamed:@"music.png"];
    } else if (_imageControl2.selectedSegmentIndex==1) {
        _textField.text=@"With family all over the country, Aiden's dad and I tried our best to spend time with all of them in his first year of life.  Luckily, my mother and stepdad lived close by, but my sister was finishing up college in Atlanta.  She finally met Aiden for the first time in December, and Aiden went on his first roadtrip to Illinois to visit his dad's parents for Thanksgiving.";
        _photo.image=[UIImage imageNamed:@"family.png"];
    } else if (_imageControl2.selectedSegmentIndex==2) {
        _textField.text=@"Aiden's first Christmas was at my mom and Tom's house on 4th St. in Boulder.  We had a huge Christmas tree with lights and shiny bulbs that fascinated him.  His favorite part was getting to tear the paper off of everyone's presents though.  That and his first taste of wine!";
        _photo.image=[UIImage imageNamed:@"christmas.png"];
    } else if (_imageControl2.selectedSegmentIndex==3) {
        _textField.text=@"One of the most special early memories for both Aiden's dad and I, was our roadtrip with all of our best friends to Rothbury, Michigan for the innagural music festival.  There were so many wonderful people, beautiful music, impressive artwork, and just plain fun that it is a memory that will stick with us forever.";
        _photo.image=[UIImage imageNamed:@"birthday.png"];
    }
}

-(void)updateTextColor{
    if (_changeTextColor.selectedSegmentIndex==0) {
        for(UIView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [(UILabel *)v setTextColor:[UIColor redColor]];
            } else if ([v isKindOfClass:[UITextView class]]) {
                [(UITextView *)v setTextColor:[UIColor redColor]];
            }
        }
    } else if (_changeTextColor.selectedSegmentIndex==1) {
        for(UIView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [(UILabel *)v setTextColor:[UIColor greenColor]];
            } else if ([v isKindOfClass:[UITextView class]]) {
                [(UITextView *)v setTextColor:[UIColor greenColor]];
            }
        }
    } else if (_changeTextColor.selectedSegmentIndex==2) {
        for(UIView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [(UILabel *)v setTextColor:[UIColor blueColor]];
            } else if ([v isKindOfClass:[UITextView class]]) {
                [(UITextView *)v setTextColor:[UIColor blueColor]];
            }
        }
    } else if (_changeTextColor.selectedSegmentIndex==3) {
        for(UIView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [(UILabel *)v setTextColor:[UIColor yellowColor]];
            } else if ([v isKindOfClass:[UITextView class]]) {
                [(UITextView *)v setTextColor:[UIColor yellowColor]];
            }
        }
    } else if (_changeTextColor.selectedSegmentIndex==4) {
        for(UIView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [(UILabel *)v setTextColor:[UIColor blackColor]];
            } else if ([v isKindOfClass:[UITextView class]]) {
                [(UITextView *)v setTextColor:[UIColor blackColor]];
            }
        }
    } else if (_changeTextColor.selectedSegmentIndex==5) {
        for(UIView *v in [self.view subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [(UILabel *)v setTextColor:[UIColor whiteColor]];
            } else if ([v isKindOfClass:[UITextView class]]) {
                [(UITextView *)v setTextColor:[UIColor whiteColor]];
            }
        }
    }
}

-(void)updateBackgroundColor{
    if (_changeBGColor.selectedSegmentIndex==0) {
        self.view.backgroundColor = [UIColor redColor];
    } else if (_changeBGColor.selectedSegmentIndex==1) {
        self.view.backgroundColor = [UIColor greenColor];
    } else if (_changeBGColor.selectedSegmentIndex==2) {
        self.view.backgroundColor = [UIColor blueColor];
    } else if (_changeBGColor.selectedSegmentIndex==3) {
        self.view.backgroundColor = [UIColor yellowColor];
    } else if (_changeBGColor.selectedSegmentIndex==4) {
        self.view.backgroundColor = [UIColor blackColor];
    } else if (_changeBGColor.selectedSegmentIndex==5) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

- (IBAction)photoChange2:(UISegmentedControl *)sender {
    [self updateImage2];
}

- (IBAction)photoChange1:(UISegmentedControl *)sender {
    [self updateImage1];
}


- (IBAction)textColor:(UISegmentedControl *)sender {
    [self updateTextColor];
}

- (IBAction)backgroundColor:(UISegmentedControl *)sender {
    [self updateBackgroundColor];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
	NSString *message = [[NSString alloc] initWithFormat:@"Hello, %@!!  Please read the description below & change the colors.", _nameField.text];
	_messageField.text=message;
}
@end
