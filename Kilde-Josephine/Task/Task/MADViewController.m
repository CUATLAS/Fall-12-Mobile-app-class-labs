//
//  MADViewController.m
//  Task
//
//  Created by Josephine Kilde on 12/14/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "MADViewController.h"
#import "MADArchive.h"

#define kFilename @"archive" //archive file name
#define kDataKey @"Data" //key value for encoding

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize task1;
@synthesize task2;
@synthesize task3;
@synthesize task4;

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
	NSString *filePath=[self dataFilePath];
    NSLog(@"%@", filePath);
    //check to see if the file exists
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        //create an instance from the archive file
        NSData *data=[[NSMutableData alloc] initWithContentsOfFile:[self dataFilePath]];
        
        //create an instance to decode the data
        NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        //read the objects from the unarchiver
        MADArchive *taskArchive=[unarchiver decodeObjectForKey:kDataKey];
        [unarchiver finishDecoding]; //tell the unarchiver we're finished
        task1.text=taskArchive.task1;
        task2.text=taskArchive.task2;
        task3.text=taskArchive.task3;
        task4.text=taskArchive.task4;
    }
    UIApplication *app=[UIApplication sharedApplication]; //application instance
    
    //subscribe to the UIApplicationWillResignActiveNotification notification
    [[NSNotificationCenter defaultCenter] addObserver:self //MADViewController should be notified
                                             selector:@selector(applicationWillResignActive:) //call applicationWillResignActive when the notification is received
                                                 name:UIApplicationWillResignActiveNotification //notification posted when the app is no longer active
                                               object:app]; //the object we're getting the notification from
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

//called when the UIApplicationWillResignActiveNotification notification is posted
-(void)applicationWillResignActive:(NSNotification *)notification{
    MADArchive *taskArchive=[[MADArchive alloc]init];
    taskArchive.task1=task1.text;
    taskArchive.task2=task2.text;
    taskArchive.task3=task3.text;
    taskArchive.task4=task4.text;
    //create an instance to hold the encoded data
    NSMutableData *data=[[NSMutableData alloc]init];
    //create instance to archive objects
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //archive objects
    [archiver encodeObject:taskArchive forKey:kDataKey];
    [archiver finishEncoding]; //tell the archiver we're finished
    //write the contents of the array to our plist file
    [data writeToFile:[self dataFilePath] atomically:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
