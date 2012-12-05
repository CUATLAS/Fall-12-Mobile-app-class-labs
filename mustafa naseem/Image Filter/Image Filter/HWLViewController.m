//
//  HWLViewController.m
//  Image Filter
//
//  Created by  on 12/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWLViewController.h"

@interface HWLViewController ()

@end

@implementation HWLViewController {
    CIContext *context; 
    CIFilter *filter; 
    CIImage *beginImage;
}
@synthesize amountSlider;
@synthesize imgV;

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
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
