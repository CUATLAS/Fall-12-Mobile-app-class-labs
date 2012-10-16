//
//  SSInfoViewController.m
//  Favorites-Multiview
//
//  Created by Scott Serafin on 10/11/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "SSInfoViewController.h"

@interface SSInfoViewController ()
@end

@implementation SSInfoViewController
@synthesize userQuote, userWord, userInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    userWord.text = userInfo.word;
    userQuote.text = userInfo.quote;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    userWord.delegate = self;
    userQuote.delegate = self;
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    
    return YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([userQuote isFirstResponder] && [touch view] != userQuote)
    {
        [userQuote resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserWord:nil];
    [self setUserQuote:nil];
    userInfo = nil;
    [super viewDidUnload];
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"done button tapped");
    
    userInfo.word = userWord.text;      // Updates what the user entered and update for the other view
    userInfo.quote = userQuote.text;    // Updates what the user entered and update for the other view
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
