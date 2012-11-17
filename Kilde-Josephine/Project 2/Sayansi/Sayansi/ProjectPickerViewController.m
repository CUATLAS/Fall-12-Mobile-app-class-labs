//
//  ProjectPickerViewController.m
//  Sayansi
//
//  Created by  on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectPickerViewController.h"

@interface ProjectPickerViewController ()

@end

@implementation ProjectPickerViewController
@synthesize projectPicker;
@synthesize projectLabel;
@synthesize subject;
@synthesize project;

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
    NSArray *array = [[NSArray alloc]initWithObjects:@"Artificial Intelligence", @"Computer Science", @"Information Technology", nil];
    self.subject = array;
	
    NSArray *array2 = [[NSArray alloc] initWithObjects:@"Introductory", @"Intermediate", @"Advanced", nil];
    self.project = array2;
}

- (void)viewDidUnload
{
    [self setProjectPicker:nil];
    [self setProjectLabel:nil];
    [super viewDidUnload];
    self.subject = nil;
    self.project = nil;
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//Methods to implement the picker. Required for the UIPickerViewDataSource protocol
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

//Retun the number of rows of data. Checks which component was picked
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
        return [self.subject count];
    else return [self.project count];
}

//Picker delegate methods. Returns the title of a given row
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0)
        return [self.subject objectAtIndex:row];
    else return [self.project objectAtIndex:row];
}

//Called when a row is selected
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //Gets the chosen row for the subject and the project
    NSInteger subjectrow = [projectPicker selectedRowInComponent:0];
    NSInteger projectrow = [projectPicker selectedRowInComponent:1];
    
    //Writes the string with the selected row's content to the label
    projectLabel.text = [NSString stringWithFormat:@"You have selected %@ from the %@ group. Press DONE to continue.", 
                         [subject objectAtIndex:subjectrow], [project objectAtIndex:projectrow]];
}



@end
