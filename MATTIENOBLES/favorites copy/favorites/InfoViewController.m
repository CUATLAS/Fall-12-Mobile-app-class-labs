//
//  InfoViewController.m
//  favorites
//
//  Created by Mattie Nobles on 10/11/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "InfoViewController.h"
//#import "MADViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize userWord;
@synthesize userQuote;
@synthesize userInfo;

-(void) viewWillAppear:(BOOL)animated{
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"done button tapped");
    userInfo.word=userWord.text;
    userInfo.quote=userQuote.text;
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(BOOL)textFieldShouldReturn:(UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"User touched");
    UITouch *touch = [touches anyObject];
    if ([userQuote isFirstResponder] && [touch view] != userQuote)
    {
        NSLog(@"The textView is currently being edited, and the user touched outside the text field");
        [userQuote resignFirstResponder];
    }
}
@end
