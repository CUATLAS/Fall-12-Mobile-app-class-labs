//
//  PlaceViewController.m
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/12/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "PlaceViewController.h"

@interface PlaceViewController ()

@end

@implementation PlaceViewController
@synthesize placeTextField, selection, delegate;

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
    placeTextField.text=[selection objectForKey:@"object"];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPlaceTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([delegate respondsToSelector:@selector(setEditedSelection:)]) {
        [placeTextField endEditing:YES];
        NSIndexPath *indexPath = [selection objectForKey:@"indexPath"]; 
        id object = placeTextField.text;
        NSDictionary *editedSelection = [NSDictionary dictionaryWithObjectsAndKeys: indexPath, @"indexPath", object, @"object", nil];
        [delegate setValue:editedSelection forKey:@"editedSelection"]; 
    }
}





@end







