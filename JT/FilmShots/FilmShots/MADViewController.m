//
//  MADViewController.m
//  FilmShots
//
//  Created by John Birchall on 9/26/12.
//  Copyright (c) 2012 John Birchall. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize shotInformation;
@synthesize shotExample;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setShotInformation:nil];
    [self setShotExample:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)extremeCloseUp:(UIButton *)sender {
     {
        shotInformation.text=@"An image that shows one subject and largely or completely excludes the background. If the subject is someone's face, only part of it is visible. Many extreme close-ups are used to increase dramatic tension. Many examples of these can be found in Western films such as 'The Good, The Bad, and The Ugly' where gun showdowns between the hero and villian are built using these shots.";
         shotExample.image=[UIImage imageNamed:@"extcloseup.png"];
        
     }
}

- (IBAction)closeUp:(UIButton *)sender {
    {
        shotInformation.text=@"An image in which the subject fills most of the frame and little of the surroundings is shown. When the subject is someone's upper body, the close-up normally reveals the entire head and perhaps some of the shoulders. Filmmakers use close-ups to direct viewer' attention to texute or to a detail or, most often, to the expressions on a person's face. In other words, close-up shots usually are put into scenes where a single character's emotions can be fully displayed. Unlike the extreme close-up where a single feature of the subject is shown, Close-ups provide more coverage while preserving the drama associated with this shot.";
        shotExample.image=[UIImage imageNamed:@"closeup.png"];
    }

}

- (IBAction)meduimShot:(UIButton *)sender {
    {
        shotInformation.text=@"A shot in which the subject and surroundings are gieven about equal importance. When the subject is a person, he or she is usually seen from the knees or waist up. Medium shots are considered one of the most typical shots used in films as they provide a good balance of showing detail and action for single or multiple subjects within the frame.";
        shotExample.image=[UIImage imageNamed:@"mediumshot.png"];
    }
}

- (IBAction)longShot:(UIButton *)sender {
    {
        shotInformation.text=@"A shot in which the subject may be seen in its entirety and much of its surroundings is visible. A long shot usually leads into a medium shot to allow more detail.";
        shotExample.image=[UIImage imageNamed:@"longshot.png"];
    }
}

- (IBAction)extremeLongShot:(UIButton *)sender {
    {
        shotInformation.text=@"A shot in which the subject appears to be far from the camera. If a person is the subject, the entire body is visible (if not obstructed by some intervening object) but very small in the frame, and much of the surroundings is visible. Usually used only outdoors, often to establish the setting of the following action. Extreme long shots can also be called establishing shots. ";
        shotExample.image=[UIImage imageNamed:@"extlongshot.png"];
    }
}

- (IBAction)dutchShot:(UIButton *)sender {
    {
        shotInformation.text=@"A camera angle in which the vertical and horizontal lines of the film's image appear at an angle to the vertical and horizontal lines of the film's frame. For example, in a Dutch angle shot, the vertical lines of a door frame appear slanted. Often used to suggest disorientation by the film's subjects or to disorient viewers or both.";
        shotExample.image=[UIImage imageNamed:@"dutchangleshot.png"];
    }
}

- (IBAction)pointOfViewShot:(UIButton *)sender {
    {
        shotInformation.text=@"Camera placement at the approximate position of a character or person (or occsionally an animal) that gives a view similar to what that subject would see. Many times Point of View shots are broken down to POV on scripts, storyboards, and other film material.";
        shotExample.image=[UIImage imageNamed:@"pointofview.png"];
    }
}

- (IBAction)shotReverseShot:(UIButton *)sender {
    {
        shotInformation.text=@"A filming and editing technique in which a shot of one subject seen from one camera position alternates with a shot of a second nearby subject seen from a different camera position. Most often used to show the face of the first person speaking or reacting as the camera looks from behind and to the side of the second person, followed by a shot of the second person's face (perhaps speaking, perhaps listening) as the first person is now seen from behind and to the side. The shot/reverse shot technique is normally used in conjunction with the 180-degree system and helps contribute to continuity editing.";
        shotExample.image=[UIImage imageNamed:@"shotreverseshot.png"];
        
    }
}

- (IBAction)highAngleShot:(UIButton *)sender {
    {
        shotInformation.text=@"A view of a subject from above, created by positioning the camera above the subject. The high angle shot is a technique employed by filmmakers to decrease a subjects power or dominance in a scene and make them look weak. By having the camera looking down at the subject, the viewer sees the subject as little and powerless.";
        shotExample.image=[UIImage imageNamed:@"highangle.png"];
    }
}

- (IBAction)lowAngleShot:(UIButton *)sender {
    {
        shotInformation.text=@"A view of the subject as seen from below eye level. Unlike high angle shots, low angle shots are used to boost a characters power and dominance. Normally the shot is reserved by Hollywood filmmakers for villians, however it can also be used to show a main characters strength. ";
        shotExample.image=[UIImage imageNamed:@"lowangle.png"];
    }
}

- (IBAction)birdsEyeViewShot:(UIButton *)sender {
    {
        shotInformation.text=@"A camera angle achieved when the camera films the subject from directly overhead. Bird's eye view is not a shot that always appears in films, however it does serve a purpose in creating a sense of freedom within a scene. It's also important to note that while the birds eye view is typically reserved for establishing wide open spaces, it can also be used to show specific details as well.";
        shotExample.image=[UIImage imageNamed:@"birdseyeview.png"];
    }
}
@end
