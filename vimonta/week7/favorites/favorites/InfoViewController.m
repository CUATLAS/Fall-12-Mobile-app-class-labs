//
//  InfoViewController.m
//  favorites
//
//  Created by Aaron Vimont on 10/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize userWord;
@synthesize userQuote;
@synthesize userInfo;

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
    userWord.delegate = self;
    userQuote.delegate = self;
}

- (void)viewDidUnload
{
    [self setUserWord:nil];
    [self setUserQuote:nil];
    userInfo = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    userWord.text = userInfo.word;
    userQuote.text = userInfo.quote;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    userInfo.word = userWord.text;
    userInfo.quote = userQuote.text;
    
    // dismisses the info view and flips back to the favorites view
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// dismisses keyboard when the user touches outside of the textview
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([userQuote isFirstResponder] && [touch view] != userQuote) {
        [userQuote resignFirstResponder];
    }
}
@end
