//
//  MADDetailViewController.m
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import "MADDetailViewController.h"
#import "MADAppDelegate.h"

@implementation MADDetailViewController
@synthesize countryList;

MADAppDelegate *app;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = countryList.name;
    app = [[UIApplication sharedApplication] delegate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return countryList.listCount;
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView: (UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        // remove any whitespace and convert GDP string to number with decimal style (add a comma every three numbers)
        NSString *trimmedString = [countryList.gdp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSInteger intNum = [trimmedString integerValue];
        NSNumber *myNum = [[NSNumber alloc] initWithInteger:intNum];
        
        NSString *formattedNum = [formatter stringFromNumber:myNum];
        
        // add dollar sign to beginning of string
        NSMutableString *dollarSign = [[NSMutableString alloc] initWithString:@"$"];
        [dollarSign appendString:formattedNum];
        
        cell.textLabel.text = dollarSign;
    }
    else if (indexPath.section == 1) {
        // remove any whitespace and convert GDP string to number with decimal style (add a comma every three numbers)
        NSString *trimmedString = [countryList.population stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSInteger intNum = [trimmedString integerValue];
        NSNumber *myNum = [[NSNumber alloc] initWithInteger:intNum];
        
        NSString *formattedNum = [formatter stringFromNumber:myNum];
        
        cell.textLabel.text = formattedNum;
    }
    else if (indexPath.section == 2) {
        NSMutableString *percentSign = [[NSMutableString alloc] initWithString:countryList.aids];
        
        // if string does not contain NA, append % sign
        if ([countryList.aids rangeOfString:@"NA"].location == NSNotFound) {
            [percentSign appendString:@"%"];
        }
        
        cell.textLabel.text = percentSign;
    }
    
    return cell;
}

- (NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName = nil;
    
    switch (section) {
        case 0:
            sectionName = @"GDP per Capita (in U.S. dollars)";
            break;
        case 1:
            sectionName = @"Population";
            break;
        case 2:
            sectionName = @"AIDS Rate (as % of pop)";
            break;
            
        default:
            break;
    }
    
    return sectionName;
}
							
@end
