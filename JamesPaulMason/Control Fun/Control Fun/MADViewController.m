//
//  MADViewController.m
//  Control Fun
//
//  Created by James Mason on 9/8/12.
//  Copyright (c) 2012 Trinary. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize imageOnScreen;
@synthesize nameField;
@synthesize numberField;
@synthesize sliderLabel;
@synthesize labelOnScreen;
@synthesize leftSwitch;
@synthesize rightSwitch;
@synthesize doSomethingButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
    UIImage *strechableButtonImageNormal = [buttonImageNormal
                                            stretchableImageWithLeftCapWidth:12
                                            topCapHeight:0];
    [doSomethingButton setBackgroundImage:strechableButtonImageNormal
                                 forState:UIControlStateNormal];
    
    UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
    UIImage *stretchableButtonImagePressed = [buttonImagePressed
                                              stretchableImageWithLeftCapWidth:12
                                              topCapHeight:0];
    [doSomethingButton setBackgroundImage:stretchableButtonImagePressed
                                 forState:UIControlStateHighlighted];
}

- (void)viewDidUnload
{
    [self setNameField:nil];
    [self setNumberField:nil];
    [self setSliderLabel:nil];
    [self setLeftSwitch:nil];
    [self setRightSwitch:nil];
    [self setDoSomethingButton:nil];
    [self setImageOnScreen:nil];
    [self setLabelOnScreen:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [nameField resignFirstResponder];
    [numberField resignFirstResponder];
}

- (IBAction)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)roundf(slider.value);
    sliderLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    sliderLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    UIFont *newFont = [UIFont systemFontOfSize:progressAsInt];
    labelOnScreen.font = newFont;
}

- (IBAction)switchChanged:(id)sender {
    UISwitch *whichSwitch = (UISwitch *)sender;
    BOOL setting = whichSwitch.isOn;
    [leftSwitch setOn:setting animated:YES];
    [rightSwitch setOn:setting animated:YES];
    if (leftSwitch.on) {
        labelOnScreen.text = [labelOnScreen.text uppercaseString];
    } else {
        labelOnScreen.text = [labelOnScreen.text lowercaseString];
    }
}

- (IBAction)toggleControls:(id)sender {
    // 0 == switches index, 1 == button index
    if ([sender selectedSegmentIndex] == 0) {
        leftSwitch.hidden = NO;
        rightSwitch.hidden = NO;
        doSomethingButton.hidden = YES;
        imageOnScreen.image = [UIImage imageNamed:@"KnifeSwitch.png"];
        labelOnScreen.text = @"Mad scientist!!!!";
    }
    else {
        leftSwitch.hidden = YES;
        rightSwitch.hidden = YES;
        doSomethingButton.hidden = NO;
        imageOnScreen.image = [UIImage imageNamed:@"SelfDestruct.png"];
        labelOnScreen.text = @"Don't do it. Don't do it!";
    }
}

- (IBAction)buttonPressed:(id)sender {
    UIActionSheet *actionSheet= [[UIActionSheet alloc]
                                 initWithTitle:@"Are you sure?"
                                 delegate:self
                                 cancelButtonTitle:@"No Way!"
                                 destructiveButtonTitle:@"Yes, I'm Sure!"
                                 otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        NSString *message = nil;
        
        if (nameField.text.length > 0)
                message = [[NSString alloc] initWithFormat:@"You can breathe easy, %@, everything went OK.", nameField.text];
        else
                message = @"You can breath easy, everything went OK";
            
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Something was done"
                              message:message
                              delegate:self
                              cancelButtonTitle:@"Phew!"
                              otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

@end