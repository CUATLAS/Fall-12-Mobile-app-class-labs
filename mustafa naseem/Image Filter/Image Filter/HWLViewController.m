//
//  HWLViewController.m
//  Image Filter
//
//  Created by  on 12/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"
#import <Twitter/Twitter.h>

@interface HWLViewController ()
@property (strong, nonatomic) NSString *imageString;
@property (strong, nonatomic) NSString *urlString;

@end

@implementation HWLViewController {
    CIContext *context; 
    CIFilter *filter; 
    CIImage *beginImage;
}
@synthesize amountSlider;
@synthesize imgV;
@synthesize imageString = _imageString;
@synthesize urlString = _urlString;

-(void) logAllFilters {
    NSArray *properties = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@", properties);
    for (NSString *filterName in properties) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"%@", [fltr attributes]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    context = [CIContext contextWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kCIContextUseSoftwareRenderer]];
    
    filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", [NSNumber numberWithFloat: 0.8], nil];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    [imgV setImage:newImg];
    
    CGImageRelease(cgimg) ;
    
    [self logAllFilters];
}

- (void)viewDidUnload
{
    [self setImgV:nil];
    [self setAmountSlider:nil];
    [super viewDidUnload];
    self.imageString = nil;
    self.urlString = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    //return (interfaceOrientation = (UIInterfaceOrientationIsPortrait(interfaceOrientation)));
}

- (IBAction)changeValue:(UISlider *)sender { 
    float slideValue = [sender value];
    
    [filter setValue:[NSNumber numberWithFloat:slideValue] forKey:@"inputIntensity"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    [imgV setImage:newImg];
    
    CGImageRelease(cgimg);
     
     
}
- (IBAction)loadPhoto:(id)sender {
    
    UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
    pickerC.delegate = self;
    [self presentModalViewController:pickerC animated:YES];
    
}

- (IBAction)savePhoto:(id)sender {
    
    CIImage *saveToSave = [filter outputImage];
    CGImageRef cgImg = [context createCGImage:saveToSave fromRect:[saveToSave extent]];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg metadata:[saveToSave properties] completionBlock:^(NSURL *assetURL, NSError *error) {
        CGImageRelease(cgImg);
    }];
                        
}

- (IBAction)tweetTapped:(id)sender {
    
    if ([TWTweetComposeViewController canSendTweet])
    {
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:@"Tweeting from my own app!"]; 
     //  [tweetSheet addImage:(UIImage *)imgV];
        [self presentModalViewController:tweetSheet animated:YES];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    
   // self.imageString = imgV;
}

- (IBAction)editButtonTapped:(UIBarButtonItem *)sender {
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 

{ 

[self dismissModalViewControllerAnimated:YES];
//NSLog(@"%@", info);
UIImage *gotImage = [info objectForKey:UIImagePickerControllerOriginalImage]; 
beginImage = [CIImage imageWithCGImage:gotImage.CGImage];
[filter setValue:beginImage forKey:kCIInputImageKey];
[self changeValue:amountSlider];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
[self dismissModalViewControllerAnimated:YES];
}

@end
