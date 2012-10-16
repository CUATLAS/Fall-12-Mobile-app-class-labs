//
//  ViewController.m
//  Favorite
//
//  Created by Stephen Feuerstein on 10/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize wordLabel;
@synthesize quoteTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize user data
    userData = [[Favorite alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    // Set label and textView strings
    wordLabel.text = userData.word;
    quoteTextView.text = userData.quote;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.wordLabel = nil;
    self.quoteTextView = nil;
    userData = nil;
}

- (IBAction)infoButtonTapped:(UIBarButtonItem *)sender
{
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    infoVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    infoVC.userData = userData;
    [self presentViewController:infoVC animated:YES completion:^{
        NSLog(@"Presenting InfoView");
                    }];
}
@end
