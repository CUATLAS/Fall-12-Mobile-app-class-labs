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

// Resize any image to fit into the cell view properly so we dont need various different versions of the same image
- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(12, 2, 46, 46);               // Create the rectangle we went to put the image into (12, 2) is position and (46, 46) is size
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;   // Fit it inside the rectangle size keeping the aspect ratio the same
    self.imageView.clipsToBounds = YES;                             // Ensure that it fits in that rectangle dangit!
}

@end
