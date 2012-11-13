//
//  MADAddViewController.m
//  Countries2
//
//  Created by Jenna Raderstrong on 10/30/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "MADAddViewController.h"

@interface MADAddViewController ()

@end

@implementation MADAddViewController
@synthesize textBox;
@synthesize addNew;


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
    addNew=textBox.text;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    
    [self setTextBox:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButton:(UIButton *)sender {
     [self dismissViewControllerAnimated:YES completion:NULL];}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{[textField resignFirstResponder];
    return YES;
}
@end
