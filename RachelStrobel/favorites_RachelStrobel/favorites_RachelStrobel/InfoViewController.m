//
//  InfoViewController.m
//  favorites_RachelStrobel
//
//  Created by Rachel Strobel on 10/11/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
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
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    userWord.text=userInfo.word;
    userQuote.text=userInfo.quote;
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
    [super viewDidUnload];
    userInfo=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"done button tapped");
    userInfo.word=userWord.text; //updates the model object with the userword before dismissing the info view
    userInfo.quote=userQuote.text; //updates the model object with the userquote before dismissing the info view
    //dismisses the info view and flips back to the favorites view
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesEnded:(NSSet *)touches
withEvent:(UIEvent *)event
{
    NSLog(@"User touched");
    UITouch *touch = [touches anyObject];
    if ([userQuote isFirstResponder] && [touch view] != userQuote)
    {
        NSLog(@"The textView is currently being edited, and the user touched outside the text view");
        [userQuote resignFirstResponder];
    }
}
@end
