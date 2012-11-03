//
//  InfoViewController.m
//  Favorite
//
//  Created by Stephen Feuerstein on 10/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize userData;
@synthesize wordTextField;
@synthesize quoteTextView;

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
    
    wordTextField.delegate = self;
    quoteTextView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.wordTextField.text = self.userData.word;
    self.quoteTextView.text = self.userData.quote;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(UIBarButtonItem *)sender
{
    // Update userData
    userData.word = self.wordTextField.text;
    userData.quote = self.quoteTextView.text;
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismissed InfoView");
        }];
}

// Resign keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Resign on outside touch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	if ([quoteTextView isFirstResponder] && [touch view] != quoteTextView)
    {
		[quoteTextView resignFirstResponder];
	}
}

-(void)dealloc
{
    /*wordTextField = nil;
    quoteTextView = nil;
    userData = nil;*/
}

@end
