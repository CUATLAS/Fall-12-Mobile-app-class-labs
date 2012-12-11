//
//  MADViewController.m
//  Task
//
//  Created by Aaron Vimont on 12/11/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADViewController.h"
#import "MADArchive.h"

#define kFilename @"archive"    // archive file name
#define kDataKey @"Data"        // key value for encoding

@interface MADViewController ()

@end

@implementation MADViewController
@synthesize task1;
@synthesize task2;
@synthesize task3;
@synthesize task4;

- (NSString *) dataFilePath {
    // locate the document dictionary
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory=[paths objectAtIndex:0];
    //creates the full path to our data file
    return [docDirectory stringByAppendingPathComponent:kFilename];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *filePath=[self dataFilePath];
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
    UIApplication *app=[UIApplication sharedApplication];
    
    //subscribe to the UIApplicationWillResignActiveNotification notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:app];
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
    [archiver finishEncoding];
    
    //write the contents of the array to our plist file
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
