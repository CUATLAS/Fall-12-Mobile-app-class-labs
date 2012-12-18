//
//  SchoolNameViewController.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "SchoolNameViewController.h"

#define kFilename @"data.plist"

@interface SchoolNameViewController () {
    NSMutableDictionary *dict;
}

@end

@implementation SchoolNameViewController

@synthesize nameTextField;
@synthesize streetTextField;
@synthesize cityTextField;
@synthesize countryTextField;
@synthesize mapView;
@synthesize saveButtonPressed;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString *)dataFilePath{
    //locates the document directory
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory=[paths objectAtIndex:0];
    //creates the full path to our data file
    return [docDirectory stringByAppendingPathComponent:kFilename];
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"title: %@", self.title);
    
    [self.mapView.delegate self];
    [self.mapView setShowsUserLocation:YES];
    
    NSString *filePath=[self dataFilePath];
    
    //check to see if the file exists
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSLog(@"file exists");
        //NSDictionary *localDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        //load the contents of the file into an array
        if ([dict objectForKey:self.title]) {
            NSArray *dataArray=[[NSArray alloc] initWithArray:[dict objectForKey:self.title]];
            //NSArray *dataArray=[[NSArray alloc]initWithContentsOfFile:filePath];
            //copy values from the ordered array into the text fields
            nameTextField.text=[dataArray objectAtIndex:0];
            streetTextField.text=[dataArray objectAtIndex:1];
            cityTextField.text=[dataArray objectAtIndex:2];
            countryTextField.text=[dataArray objectAtIndex:3];
        }
    }
    else {
        dict = [[NSMutableDictionary alloc] init];
    }
    UIApplication *app=[UIApplication sharedApplication]; //application instance
    //subscribe to the UIApplicationWillResignActiveNotification notification
    [[NSNotificationCenter defaultCenter] addObserver:self //MADViewController should be notified
                                             selector:@selector(applicationWillResignActive:) //call applicationWillResignActive when the notification is received
                                                 name:UIApplicationWillResignActiveNotification //notification posted when the app is no longer active
                                               object:app]; //the object we're getting the notification from
}

-(void)schoolMapV:(MKMapView *)schoolMap didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
}
 
- (void)viewDidUnload
{
    
    [self setNameTextField:nil];
    [self setStreetTextField:nil];
    [self setCityTextField:nil];
    [self setCountryTextField:nil];
    [self setMapView:nil];
    [self setSaveButtonPressed:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//called when the UIApplicationWillResignActiveNotification notification is posted
-(void)applicationWillResignActive:(NSNotification *)notification{
    //NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    //create a mutable array and add the data from the text fields to it
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:nameTextField.text];
    [array addObject:streetTextField.text];
    [array addObject:cityTextField.text];
    [array addObject:countryTextField.text];
    //write the contents of the array to our plist file
    [dict setObject:array forKey:self.title];
    
    [dict writeToFile:[self dataFilePath] atomically:YES];
    //[array writeToFile:[self dataFilePath] atomically:YES];
}
 
-(IBAction)saveButtonPressed:(id)sender {
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:nameTextField.text];
    [array addObject:streetTextField.text];
    [array addObject:cityTextField.text];
    [array addObject:countryTextField.text];
    //write the contents of the array to our plist file
    [dict setObject:array forKey:self.title];
    
    [dict writeToFile:[self dataFilePath] atomically:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
