//
//  CustomCell.m
//  Craftipedia
//
//  Created by Scott Serafin on 10/2/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize itemNameLabel;
@synthesize itemIDLabel;
@synthesize itemImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
