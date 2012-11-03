//
//  MADParser.m
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//
//
//  Much of the code in MADParser.m was designed in part from iElmo Tutorials,
//  which can be found at http://www.youtube.com/watch?v=-PZlaDVsLBk&feature=relmfu
//  and https://github.com/iElmo/XML
//


#import "MADParser.h"

@implementation MADParser

-(id) initParser {
    if (self == [super init]) {
        app = (MADAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"Countries"]) {
        // if the list has not initialized, create it
        app.listArray = [[NSMutableArray alloc] init];
    }
    else if ([elementName isEqualToString:@"Country"]) {
        // if the country list has not been initialized, create it
        countryList = [[MADCountryList alloc] init];
        
        // get the country ID
        countryList.countryID = [[attributeDict objectForKey:@"id"] integerValue];
    }
    // if the GDP is selected in the segment, check the gdp value
    else if([elementName isEqualToString:@"Gdp" ] && [MADStoredData sharedInstance].currentSegment == 0){
        [MADStoredData sharedInstance].checkGdp = YES;
    }
    // if the population is selected in the segment, check the pop value
    else if([elementName isEqualToString:@"Population" ] && [MADStoredData sharedInstance].currentSegment == 1){
        [MADStoredData sharedInstance].checkPop = YES;
    }
    // if aids is selected in the segment, check the aids value
    else if([elementName isEqualToString:@"Aids" ] && [MADStoredData sharedInstance].currentSegment == 2){
        [MADStoredData sharedInstance].checkAids = YES;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        [currentElementValue appendString:string];
        // check gdp value
        if ([MADStoredData sharedInstance].checkGdp) {
            // remove potential whitespace
            NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([trimmedString floatValue] <= [MADStoredData sharedInstance].gdpValue) {
                [MADStoredData sharedInstance].skipThisCountry = YES;
            }
            [MADStoredData sharedInstance].checkGdp = NO;
        }
        // check pop value
        if ([MADStoredData sharedInstance].checkPop) {
            // remove potential whitespace
            NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([trimmedString floatValue] <= [MADStoredData sharedInstance].popValue) {
                [MADStoredData sharedInstance].skipThisCountry = YES;
            }
            [MADStoredData sharedInstance].checkPop = NO;
        }
        // check aids value
        if ([MADStoredData sharedInstance].checkAids) {
            // remove potential whitespace
            NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([trimmedString floatValue] <= [MADStoredData sharedInstance].aidsValue) {
                [MADStoredData sharedInstance].skipThisCountry = YES;
            }
            [MADStoredData sharedInstance].checkAids = NO;
        }
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"Countries"]) {
        return;
    }
    else if ([elementName isEqualToString:@"Country"]) {
        // check for segment
        if ([MADStoredData sharedInstance].currentSegment != -1) {
            // skip the country if necessary
            if ([MADStoredData sharedInstance].skipThisCountry) {
                [MADStoredData sharedInstance].skipThisCountry = NO;
            }
            // add the country
            else if (![MADStoredData sharedInstance].skipThisCountry) {
                [app.listArray addObject:countryList];
                [MADStoredData sharedInstance].skipThisCountry = NO;
            }
        }
        // if segment not clicked, add the country list
        else if ([MADStoredData sharedInstance].currentSegment == -1) {
            [app.listArray addObject:countryList];
        }

        countryList = nil;
    }
    else {
        [countryList setValue:currentElementValue forKey:elementName];
        
    }
    
    currentElementValue = nil;
}

@end
