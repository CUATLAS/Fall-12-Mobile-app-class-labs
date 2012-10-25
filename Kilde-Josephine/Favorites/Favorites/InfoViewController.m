//
//  InfoViewController.m
//  Favorites
//
//  Created by  on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize userWord;
@synthesize userQuote;
@synthesize userInfo;

//Set the username and userquote just before the iew appears
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    userWord.text=userInfo.word;
    userQuote.text=userInfo.quote;
}

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
    userWord.delegate=self;
    userQuote.delegate=self;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUserWord:nil];
    [self setUserQuote:nil];
    userInfo=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"done button tapped");
    userInfo.word=userWord.text;
    //Updates the model object with the userwrd before dismissing the info view
    userInfo.quote=userQuote.text;
    //Updates the model object with the user quote before dismissing the info view
    //Dismisses the infor view and flips back to the favorites view
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//Dismisses keyboard when the user touches outside the textview
//From iphonedevelopertips.com
- (void)touchesEnded:(NSSet *)touches 
           withEvent:(UIEvent *)event
{
    NSLog(@"user touched");
    UITouch *touch = [touches anyObject];
    if ([userQuote isFirstResponder] && [touch view] != userQuote)
    {
        NSLog(@"The textview is currently being edited, and the user touched outside the text view");
        [userQuote resignFirstResponder];
    }
}
@end
