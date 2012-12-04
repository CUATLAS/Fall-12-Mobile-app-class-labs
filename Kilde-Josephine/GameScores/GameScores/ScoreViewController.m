//
//  ScoreViewController.m
//  GameScores
//
//  Created by  on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController
@synthesize scoreTextField, selection, delegate;

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([delegate respondsToSelector:@selector(setEditedSelection:)]) {
        //Forces the text field to finish any editing the user may have been doing so that its text value is uptodate
        [scoreTextField endEditing:YES];
        NSIndexPath *indexPath = [selection objectForKey:@"indexPath"]; //Gets the index path
        id object = scoreTextField.text;
        NSDictionary *editedSelection = [NSDictionary dictionaryWithObjectsAndKeys:
                                         indexPath, @"indexPath",
                                         object, @"object",
                                         nil];
        [delegate setValue:editedSelection forKey:@"editedSelection"]; //Sets the delegate's editedSelection property
    }
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
    scoreTextField.text=[selection objectForKey:@"object"];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setScoreTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
