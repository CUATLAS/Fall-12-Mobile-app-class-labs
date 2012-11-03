//
//  InfoViewController.m
//  Favorites
//
//  Created by Elise J Beall on 10/11/12.
//  Copyright (c) 2012 Elise J Beall. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize userQuote;
@synthesize userWord;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"done button tapped");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//UITextFieldDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//dissmisses keyboard when the user touches outside the textview from http://iphonedevelopertips.com/cocoa/how-to-dismiss-the-keyboard-when-using-a-uitextview.html
-(void)touchesEnded:(NSSet *)touches
          withEvent:(UIEvent *)event {
    NSLog(@"User touched");
    UITouch *touch = [touches anyObject];
    if ([userQuote isFirstResponder] && [touch view] != userQuote)
    {
        NSLog(@"The textView is currently being edited, and the user touched outside the text view.");
        [userQuote resignFirstResponder];
    }
}

@end
