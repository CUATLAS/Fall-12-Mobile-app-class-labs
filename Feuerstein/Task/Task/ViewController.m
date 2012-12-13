//
//  ViewController.m
//  Task
//
//  Created by Stephen Feuerstein on 12/11/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "ViewController.h"

#define kFILENAME @"data.plist"

@interface ViewController ()

@end

@implementation ViewController

-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    NSLog(@"%@", [docDirectory stringByAppendingPathComponent:kFILENAME]);
    return [docDirectory stringByAppendingPathComponent:kFILENAME];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:self.task1.text];
    [array addObject:self.task2.text];
    [array addObject:self.task3.text];
    [array addObject:self.task4.text];
    
    [array writeToFile:[self dataFilePath] atomically:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:filePath];
        
        self.task1.text = [dataArray objectAtIndex:0];
        self.task2.text = [dataArray objectAtIndex:1];
        self.task3.text = [dataArray objectAtIndex:2];
        self.task4.text = [dataArray objectAtIndex:3];
    }
    
    // Set up notification center for when app resigns active
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:app];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTask1:nil];
    [self setTask2:nil];
    [self setTask3:nil];
    [self setTask4:nil];
    [super viewDidUnload];
}
@end
