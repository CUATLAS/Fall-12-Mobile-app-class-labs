//
//  InfoViewController.m
//  Favorites
//
//  Created by Jenna Raderstrong on 10/15/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
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
    userWord.delegate=self;
	userQuote.delegate=self;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUserWord:nil];
    [self setUserQuote:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
   
        //dismisses the info view and flips back to the favorites view
        [self dismissViewControllerAnimated:YES completion:NULL];
    userInfo.word=userWord.text;
      userInfo.quote=userQuote.text; 
    }

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

//dismisses keyboard when the user touches outside the textview
// from http://iphonedevelopertips.com/cocoa/how-to-dismiss-the-keyboard-when-using-a-uitextview.html
- (void)touchesEnded:(NSSet *)touches
		   withEvent:(UIEvent *)event
{
	NSLog(@"User touched");
	UITouch *touch = [touches anyObject];
	if ([userQuote isFirstResponder] && [touch view] != userQuote) {
		NSLog(@"The textView is currently being edited, and the user touched outside the text view");
		[userQuote resignFirstResponder];
	}
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    userWord.text=userInfo.word;
    userQuote.text=userInfo.quote;}

@end






