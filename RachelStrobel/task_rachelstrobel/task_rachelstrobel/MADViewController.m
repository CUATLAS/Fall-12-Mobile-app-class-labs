//
//  MADViewController.m
//  task_rachelstrobel
//
//  Created by Rachel Strobel on 12/11/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADViewController.h"

#define kFilename @"data.plist"

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize task1;
@synthesize task2;
@synthesize task3;
@synthesize task4;

-(NSString *) dataFilePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory=[paths objectAtIndex:0];
    NSLog(@"%@", [docDirectory stringByAppendingPathComponent:kFilename]);
    return [docDirectory stringByAppendingPathComponent:kFilename];
    
}- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath=[self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *dataArray=[[NSArray alloc] initWithContentsOfFile:filePath];
        task1.text=[dataArray objectAtIndex:0];
        task2.text=[dataArray objectAtIndex:1];
        task3.text=[dataArray objectAtIndex:2];
        task4.text=[dataArray objectAtIndex:3];
    }
    UIApplication *app=[UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector
     (applicationWillResignActive:)
                                                 name:
     UIApplicationWillResignActiveNotification
                                               object:app];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTask1:nil];
    [self setTask2:nil];
    [self setTask3:nil];
    [self setTask4:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)applicationWillResignActive:(NSNotification *)notification{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:task1.text];
    [array addObject:task2.text];
    [array addObject:task3.text];
    [array addObject:task4.text];
    [array writeToFile:[self dataFilePath] atomically:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
