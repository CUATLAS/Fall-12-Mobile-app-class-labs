//
//  MADHomeViewController.m
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADHomeViewController.h"
#import "MADMasterViewController.h"
#import "InfoViewController.h"
#import "MADSwipeContainer.h"
#import "MADSwipeData.h"

@interface MADHomeViewController () {
    MADMasterViewController *masterViewController;
    NSMutableArray *swipeItemData;
    NSArray *titlesForSwipeItems;
    
    MADSwipeContainer *leftContainer;
    MADSwipeContainer *middleContainer;
    MADSwipeContainer *rightContainer;
    BOOL firstTimeInputShown;
    BOOL goingToInfoScreen;
}

@end

@implementation MADHomeViewController
@synthesize theSegment;
@synthesize infoLabel;
@synthesize leftLowValue;
@synthesize leftHighValue;
@synthesize leftLabel;
@synthesize middleLabel;
@synthesize middleLowValue;
@synthesize middleHighValue;
@synthesize rightLabel;
@synthesize rightLowValue;
@synthesize rightHighValue;
@synthesize lowValueLabel;
@synthesize highValueLabel;
@synthesize swipeView;
@synthesize showHideButton;
@synthesize showTableButton;
@synthesize warningLabel;
@synthesize earthImage;

BOOL inputIsOpen                = NO;

// constants for on and off screen positions
float labelYPos                 = 24.0f;
float textFieldYPos             = 64.0f;

float labelOffScreenLeftPos     = -165.0f;
float lowValOffScreenLeftPos    = -205.0f;
float highValOffScreenLeftPos   = -49.0f;

float labelOffScreenRightPos    = 460.0f;
float lowValOffScreenRightPos   = 402.0f;
float highValOffScreenRightPos  = 558.0f;

float labelOnScreenPos          = 140.0f;
float lowValOnScreenPos         = 82.0f;
float highValOnScreenPos        = 238.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)moveSwipeContainersToBeginning {
    
    // set the array items
    [leftContainer setAllItems:leftLabel lowText:leftLowValue highText:leftHighValue];
    [middleContainer setAllItems:middleLabel lowText:middleLowValue highText:middleHighValue];
    [rightContainer setAllItems:rightLabel lowText:rightLowValue highText:rightHighValue];
    
    // move the label and text fields
    [leftContainer moveCenterLabelX:labelOffScreenLeftPos labelY:labelYPos lowValX:lowValOffScreenLeftPos lowValY:textFieldYPos highValX:highValOffScreenLeftPos highValY:textFieldYPos];
    [middleContainer moveCenterLabelX:labelOnScreenPos labelY:labelYPos lowValX:lowValOnScreenPos lowValY:textFieldYPos highValX:highValOnScreenPos highValY:textFieldYPos];
    [rightContainer moveCenterLabelX:labelOffScreenRightPos labelY:labelYPos lowValX:lowValOffScreenRightPos lowValY:textFieldYPos highValX:highValOffScreenRightPos highValY:textFieldYPos];
    
    // set the strings
    leftContainer.title.text = @"";
    
    MADSwipeData *tempData = [swipeItemData objectAtIndex:0];
    middleContainer.title.text = tempData.labelText;
    middleContainer.lowValTextField.text = tempData.lowValText;
    middleContainer.highValTextField.text = tempData.highValText;
    
    tempData = [swipeItemData objectAtIndex:1];
    rightContainer.title.text = tempData.labelText;
    rightContainer.lowValTextField.text = tempData.lowValText;
    rightContainer.highValTextField.text = tempData.highValText;
    
    leftContainer.title.hidden = YES;
    leftContainer.lowValTextField.hidden = YES;
    leftContainer.highValTextField.hidden = YES;
    
    middleContainer.title.hidden = YES;
    middleContainer.lowValTextField.hidden = YES;
    middleContainer.highValTextField.hidden = YES;
    
    rightContainer.title.hidden = YES;
    rightContainer.lowValTextField.hidden = YES;
    rightContainer.highValTextField.hidden = YES;
}

- (void)resetSwipeItemData {
    swipeItemData = nil;
    swipeItemData = [[NSMutableArray alloc] initWithCapacity:ARRAYLENGTH];
    MADSwipeData *tempContainer = [[MADSwipeData alloc] init];
    for (NSInteger i = 0; i < ARRAYLENGTH; i++) {
        tempContainer = nil;
        tempContainer = [[MADSwipeData alloc] init];
        [tempContainer setLabelText:[titlesForSwipeItems objectAtIndex:i]];
        [tempContainer setLowValText:@""];
        [tempContainer setHighValText:@""];
        [swipeItemData insertObject:tempContainer atIndex:i];
        //[swipeItemData replaceObjectAtIndex:i withObject:tempContainer];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // boolean to show swipe instructions
    firstTimeInputShown = YES;
    goingToInfoScreen = NO;
    
    // add swipe right gesture recognition to swipeView
    swipeView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipeRIGHT = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveTextFieldsRight)];
    swipeRIGHT.numberOfTouchesRequired = 1;
    swipeRIGHT.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeView addGestureRecognizer:swipeRIGHT];
    
    // add swipe left gesture recognition to swipeView
    UISwipeGestureRecognizer *swipeLEFT = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveTextFieldsLeft)];
    swipeLEFT.numberOfTouchesRequired = 1;
    swipeLEFT.direction = UISwipeGestureRecognizerDirectionLeft;
    [swipeView addGestureRecognizer:swipeLEFT];
    
    leftContainer = [[MADSwipeContainer alloc] init];
    middleContainer = [[MADSwipeContainer alloc] init];
    rightContainer = [[MADSwipeContainer alloc] init];
    
    // set text field delegates
    leftLowValue.delegate = self;
    leftHighValue.delegate = self;
    middleLowValue.delegate = self;
    middleHighValue.delegate = self;
    rightLowValue.delegate = self;
    rightHighValue.delegate = self;
    
    // set titles
    titlesForSwipeItems = [[NSArray alloc] initWithObjects:@"GDP/ capita - In $US", @"Population - In Millions", @"AIDS Rate - as % of Pop.", nil];
    
    // set array of swipeable objects
    [self resetSwipeItemData];
    
    // move swipe containers to start
    [self moveSwipeContainersToBeginning];
}

- (void)viewDidUnload
{
    [self setTheSegment:nil];
    [self setInfoLabel:nil];
    [self setLeftLowValue:nil];
    [self setLeftHighValue:nil];
    [self setSwipeView:nil];
    [self setLeftLabel:nil];
    [self setMiddleLabel:nil];
    [self setMiddleLowValue:nil];
    [self setMiddleHighValue:nil];
    [self setRightLabel:nil];
    [self setRightLowValue:nil];
    [self setRightHighValue:nil];
    [self setShowHideButton:nil];
    [self setLowValueLabel:nil];
    [self setHighValueLabel:nil];
    [self setShowTableButton:nil];
    [self setWarningLabel:nil];
    [self setEarthImage:nil];
    swipeItemData = nil;
    leftContainer = nil;
    middleContainer = nil;
    rightContainer = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!goingToInfoScreen) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        goingToInfoScreen = NO;
    } else {
        goingToInfoScreen = NO;
    }
    [warningLabel setAlpha:0.0];
    [super viewWillAppear:animated];
    // handle orientation if view loads in landscape mode
    //UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    //[self adjustViewsForOrientation:orientation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (!goingToInfoScreen) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self adjustViewsForOrientation:toInterfaceOrientation];
}*/

/*- (void) adjustViewsForOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        earthImage.center = CGPointMake(90.0f, 150.0f);
    }
    else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        earthImage.center = CGPointMake(165.0f, 140.0f);
    }
}*/

- (void) moveTextFieldsRight {
    
    // set shared low and high values back to 0
    [MADStoredData sharedInstance].lowValue = 0.0;
    [MADStoredData sharedInstance].highValue = 0.0;
    int currentSwipePos = [MADStoredData sharedInstance].currentSegment;
    
    if (currentSwipePos > 0) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        
        // move middle container off screen and right container on screen
        [middleContainer moveCenterLabelX:labelOffScreenRightPos labelY:labelYPos lowValX:lowValOffScreenRightPos lowValY:textFieldYPos highValX:highValOffScreenRightPos highValY:textFieldYPos];
        [leftContainer moveCenterLabelX:labelOnScreenPos labelY:labelYPos lowValX:lowValOnScreenPos lowValY:textFieldYPos highValX:highValOnScreenPos highValY:textFieldYPos];
        
        // set frame in case text gets blurry
        [leftContainer.title setFrame:CGRectIntegral(leftContainer.title.frame)];
        [leftContainer.lowValTextField setFrame:CGRectIntegral(leftContainer.lowValTextField.frame)];
        [leftContainer.highValTextField setFrame:CGRectIntegral(leftContainer.highValTextField.frame)];
        
        [UIView commitAnimations];
        
        // change low and high values of swipeItemData
        MADSwipeData *tempData = [swipeItemData objectAtIndex:currentSwipePos];
        tempData.lowValText = middleContainer.lowValTextField.text;
        tempData.highValText = middleContainer.highValTextField.text;
        [swipeItemData replaceObjectAtIndex:currentSwipePos withObject:tempData];
        
        // change left, middle, and right containers to appropriate positions, etc.
        [rightContainer moveCenterLabelX:labelOffScreenLeftPos labelY:labelYPos lowValX:lowValOffScreenLeftPos lowValY:textFieldYPos highValX:highValOffScreenLeftPos highValY:textFieldYPos];
        MADSwipeContainer *tempRight = rightContainer;
        rightContainer = middleContainer;
        middleContainer = leftContainer;
        leftContainer = tempRight;
        
        currentSwipePos--;
        
        // set strings of left and right containers to match sharedItemData
        if (currentSwipePos - 1 > 0) {
            tempData = [swipeItemData objectAtIndex:currentSwipePos - 1];
            leftContainer.title.text = tempData.labelText;
            leftContainer.lowValTextField.text = tempData.lowValText;
            leftContainer.highValTextField.text = tempData.highValText;
        }
        
        tempData = [swipeItemData objectAtIndex:currentSwipePos + 1];
        rightContainer.title.text = tempData.labelText;
        rightContainer.lowValTextField.text = tempData.lowValText;
        rightContainer.highValTextField.text = tempData.highValText;
        
        [MADStoredData sharedInstance].currentSegment = currentSwipePos;
    }
}

- (void) moveTextFieldsLeft {
    
    // set shared low and high values back to 0
    [MADStoredData sharedInstance].lowValue = 0.0;
    [MADStoredData sharedInstance].highValue = 0.0;
    
    int currentSwipePos = [MADStoredData sharedInstance].currentSegment;
    
    // case when swiping from left to right is allowed. All cases except last item in swipeItems
    if ((currentSwipePos >= 0) && (currentSwipePos < [swipeItemData count] - 1)) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        
        // move middle container off screen and right container on screen
        [middleContainer moveCenterLabelX:labelOffScreenLeftPos labelY:labelYPos lowValX:lowValOffScreenLeftPos lowValY:textFieldYPos highValX:highValOffScreenLeftPos highValY:textFieldYPos];
        [rightContainer moveCenterLabelX:labelOnScreenPos labelY:labelYPos lowValX:lowValOnScreenPos lowValY:textFieldYPos highValX:highValOnScreenPos highValY:textFieldYPos];
        
        [UIView commitAnimations];
        
        // set frame in case text gets blurry
        [rightContainer.title setFrame:CGRectIntegral(rightContainer.title.frame)];
        [rightContainer.lowValTextField setFrame:CGRectIntegral(rightContainer.lowValTextField.frame)];
        [rightContainer.highValTextField setFrame:CGRectIntegral(rightContainer.highValTextField.frame)];
        
        // change low and high values of swipeItemData
        MADSwipeData *tempData = [swipeItemData objectAtIndex:currentSwipePos];
        tempData.lowValText = middleContainer.lowValTextField.text;
        tempData.highValText = middleContainer.highValTextField.text;
        [swipeItemData replaceObjectAtIndex:currentSwipePos withObject:tempData];
        
        // change left, middle, and right containers to appropriate positions, etc.
        [leftContainer moveCenterLabelX:labelOffScreenRightPos labelY:labelYPos lowValX:lowValOffScreenRightPos lowValY:textFieldYPos highValX:highValOffScreenRightPos highValY:textFieldYPos];
        MADSwipeContainer *tempLeft = leftContainer;
        leftContainer = middleContainer;
        middleContainer = rightContainer;
        rightContainer = tempLeft;
        
        currentSwipePos++;
        
        // set strings of left and right containers to match sharedItemData
        tempData = [swipeItemData objectAtIndex:currentSwipePos - 1];
        leftContainer.title.text = tempData.labelText;
        leftContainer.lowValTextField.text = tempData.lowValText;
        leftContainer.highValTextField.text = tempData.highValText;
        
        if (currentSwipePos + 1 < [swipeItemData count]) {
            tempData = [swipeItemData objectAtIndex:currentSwipePos + 1];
            rightContainer.title.text = tempData.labelText;
            rightContainer.lowValTextField.text = tempData.lowValText;
            rightContainer.highValTextField.text = tempData.highValText;
        }

        [MADStoredData sharedInstance].currentSegment = currentSwipePos;
    }
}

- (IBAction)showTheTable:(UIButton *)sender {
    
    /* Before loading the table, check to make sure one of the inputs is not
     * being used. If it is, check which one and set the high and low values
     * of the Shared Data to the input fields.
     */
    // Check to make sure inputs are not negative or the low is greater than the high
    if ([MADStoredData sharedInstance].currentSegment != -1) {
        NSString *theLowVal = middleContainer.lowValTextField.text;
        NSString *trimmedLowString = [theLowVal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSCharacterSet *decimalSet = [NSCharacterSet decimalDigitCharacterSet];
        
        // check to make sure no letters or characters are in the text fields
        if ([[trimmedLowString stringByTrimmingCharactersInSet:decimalSet] isEqualToString:@""] ||
            [[trimmedLowString stringByTrimmingCharactersInSet:decimalSet] isEqualToString:@"."]) {
            [MADStoredData sharedInstance].lowValue = [trimmedLowString floatValue];
        } else {
            [MADStoredData sharedInstance].lowValue = -1.0;
        }
        
        // Get High Value of AIDS
        NSString *theHighVal = middleContainer.highValTextField.text;
        NSString *trimmedHighString = [theHighVal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // check to make sure no letters or characters are in the text fields
        if ([[trimmedHighString stringByTrimmingCharactersInSet:decimalSet] isEqualToString:@""] ||
            [[trimmedHighString stringByTrimmingCharactersInSet:decimalSet] isEqualToString:@"."]){
            [MADStoredData sharedInstance].highValue = [trimmedHighString floatValue];
        } else {
            [MADStoredData sharedInstance].highValue = -1.0;
        }
        
        NSLog(@"low: %f high: %f", [MADStoredData sharedInstance].lowValue, [MADStoredData sharedInstance].highValue);
        if ([MADStoredData sharedInstance].lowValue < 0.0 ||
            [MADStoredData sharedInstance].highValue < 0.0 ||
            [MADStoredData sharedInstance].highValue < [MADStoredData sharedInstance].lowValue ||
            ([MADStoredData sharedInstance].highValue == 0.0 && [MADStoredData sharedInstance].lowValue == 0.0)) {
            
            warningLabel.textColor = [UIColor redColor];
            warningLabel.text = @"Please Enter Valid Inputs";
            [warningLabel setAlpha:1.0];
            
            return;
        }
    }
    
    // push and load the table view
    //MADMasterViewController *masterView = [[MADMasterViewController alloc] init];
    if (!masterViewController) {
        masterViewController = [[MADMasterViewController alloc] initWithNibName:@"MADMasterViewController" bundle:nil];
    }
    masterViewController.title = @"Countries";
    [self.navigationController pushViewController:masterViewController animated:YES];
    
}

- (IBAction)resetTable:(UIButton *)sender {
    //[MADStoredData sharedInstance].currentSegment = -1;
    [warningLabel setAlpha:0.0];
    if (inputIsOpen) {
        [self showHideInput:showHideButton];
    }
    [self resetSwipeItemData];
    [self moveSwipeContainersToBeginning];
    [MADStoredData sharedInstance].oldSegment = 0;
}

- (IBAction)showHideInput:(UIButton *)sender {
    if (!inputIsOpen) {
        CGRect newFrameSize = CGRectMake(0, 130, 320, 127);
        
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             swipeView.frame = newFrameSize;
                             earthImage.frame = CGRectMake(0.0, 30.0, 320.0, 320.0);
                             [earthImage setAlpha:0.2];
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 lowValueLabel.hidden = NO;
                                 highValueLabel.hidden = NO;
                                 
                                 leftContainer.title.hidden = NO;
                                 leftContainer.lowValTextField.hidden = NO;
                                 leftContainer.highValTextField.hidden = NO;
                                 
                                 middleContainer.title.hidden = NO;
                                 middleContainer.lowValTextField.hidden = NO;
                                 middleContainer.highValTextField.hidden = NO;
                                 
                                 rightContainer.title.hidden = NO;
                                 rightContainer.lowValTextField.hidden = NO;
                                 rightContainer.highValTextField.hidden = NO;
                             }
                         }];
        if (firstTimeInputShown) {
            warningLabel.textColor = [UIColor darkTextColor];
            warningLabel.text = @"Swipe Left and Right to Change Input";
            [warningLabel setAlpha:1.0];
            firstTimeInputShown = NO;
        }
        inputIsOpen = YES;
        [showHideButton setTitle:@"Hide" forState:UIControlStateNormal];
        [showTableButton setTitle:@"Show Filtered Country List" forState:UIControlStateNormal];
        [MADStoredData sharedInstance].currentSegment = [MADStoredData sharedInstance].oldSegment;
    }
    else if (inputIsOpen) {
        CGRect newFrameSize = CGRectMake(0, 166, 320, 0);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        swipeView.frame = newFrameSize;
        earthImage.frame = CGRectMake(56.0, 66.0, 200.0, 200.0);
        [earthImage setAlpha:1.0];
        [warningLabel setAlpha:0.0];
        
        lowValueLabel.hidden = YES;
        highValueLabel.hidden = YES;
        
        leftContainer.title.hidden = YES;
        leftContainer.lowValTextField.hidden = YES;
        leftContainer.highValTextField.hidden = YES;
        
        middleContainer.title.hidden = YES;
        middleContainer.lowValTextField.hidden = YES;
        middleContainer.highValTextField.hidden = YES;
        
        rightContainer.title.hidden = YES;
        rightContainer.lowValTextField.hidden = YES;
        rightContainer.highValTextField.hidden = YES;
        
        [UIView commitAnimations];
        inputIsOpen = NO;
        [showHideButton setTitle:@"Add Input" forState:UIControlStateNormal];
        [showTableButton setTitle:@"Show Complete Country List" forState:UIControlStateNormal];
        [MADStoredData sharedInstance].oldSegment = [MADStoredData sharedInstance].currentSegment;
        [MADStoredData sharedInstance].currentSegment = -1;
    }
}

- (IBAction)infoButtonTapped:(UIButton *)sender {
    goingToInfoScreen = YES;
    InfoViewController *infoViewController = [[InfoViewController alloc] init];
    [infoViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:infoViewController animated:YES completion:NULL];
}

- (IBAction)highValueDoneEditing:(UITextField *)sender {
    [sender resignFirstResponder];
    
    NSString *myHighVal = sender.text;
    NSString *trimmedString = [myHighVal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //float tempHigh = [trimmedString floatValue];
    [MADStoredData sharedInstance].highValue = [trimmedString floatValue];
}

- (IBAction)lowValueDoneEditing:(UITextField *)sender {
    [sender resignFirstResponder];
    
    NSString *myLowVal = sender.text;
    NSString *trimmedString = [myLowVal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //float tempHigh = [trimmedString floatValue];
    [MADStoredData sharedInstance].lowValue = [trimmedString floatValue];
}

// text field delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [warningLabel setAlpha:0.0];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([middleContainer.lowValTextField isFirstResponder] && [touch view] != middleContainer.lowValTextField) {
        [middleContainer.lowValTextField resignFirstResponder];
    }
    else if ([middleContainer.highValTextField isFirstResponder] && [touch view] != middleContainer.highValTextField) {
        [middleContainer.highValTextField resignFirstResponder];
    }
    
}

@end
