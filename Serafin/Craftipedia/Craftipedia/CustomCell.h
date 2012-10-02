//
//  CustomCell Is used to create/format the table view custom cells
//  Craftipedia
//
//  Created by Scott Serafin on 10/2/12.
//  Copyright (c) 2012 Scott Serafin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;

@end
