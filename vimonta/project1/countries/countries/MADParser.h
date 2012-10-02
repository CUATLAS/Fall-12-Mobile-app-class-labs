//
//  MADParser.h
//  countries
//
//  Created by Aaron Vimont on 9/24/12.
//  Copyright (c) 2012 Aaron Vimont. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADAppDelegate.h"
#import "MADCountryList.h"
#import "MADStoredData.h"

@interface MADParser : NSObject <NSXMLParserDelegate> {
    MADAppDelegate *app;
    MADCountryList *countryList;
    NSMutableString *currentElementValue;
}

-(id)initParser;

@end
