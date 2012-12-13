//
//  TextFieldCell.m
//  Tasks
//
//  Created by Stephen Feuerstein on 11/13/12.
//  Copyright (c) 2012 Stephen Feuerstein. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

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
