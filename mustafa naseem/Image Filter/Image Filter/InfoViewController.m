//
//  InfoViewController.m
//  Image Filter
//
//  Created by  on 12/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController 
{   CIContext *context;
    CIFilter *filter;
    CIImage *beginImage;
}
@synthesize amountSlider;
@synthesize imgV1;
@synthesize userInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    imgV1.image=userInfo.picture;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    

    
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    context = [CIContext contextWithOptions:nil];
    
    filter = [CIFilter filterWithName:@"CISepiaTone" 
                        keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", 
              [NSNumber numberWithFloat:0.8], nil];
    
}

- (void)viewDidUnload
{
    [self setAmountSlider:nil];
    [self setImgV1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    
    NSLog(@"done button tapped");
   [self dismissViewControllerAnimated:YES completion:NULL];
    userInfo.picture=imgV1.image;
}

- (IBAction)changeValue:(UISlider *)sender {
    
    float slideValue = [sender value];
    
    [filter setValue:[NSNumber numberWithFloat:slideValue] 
              forKey:@"inputIntensity"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage 
                                     fromRect:[outputImage extent]];
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];    
    [imgV1 setImage:newImg];
    
    CGImageRelease(cgimg);
}
@end
