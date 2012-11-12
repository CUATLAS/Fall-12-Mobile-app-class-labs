//
//  ScoreViewController.m
//  GameScores
//
//  Created by Stephen Feuerstein on 11/6/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController
@synthesize scoreTextField, selection, delegate;

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
	// Do any additional setup after loading the view.
    scoreTextField.text = [selection objectForKey:@"object"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([delegate respondsToSelector:@selector(setEditedSelection:)])
    {
        [scoreTextField endEditing:YES];
        
        NSIndexPath *indexPath = [selection objectForKey:@"indexPath"];
        id object = scoreTextField.text;
        
        NSDictionary *editedSelection = [NSDictionary dictionaryWithObjectsAndKeys:
                                         indexPath, @"indexPath",
                                         object, @"object", nil];
        [delegate setValue:editedSelection forKey:@"editedSelection"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScoreTextField:nil];
    [super viewDidUnload];
}
@end
