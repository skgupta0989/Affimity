//
//  customTableViewCell.m
//  Affimity
//
//  Created by sandeep kumar gupta on 17/01/15.
//  Copyright (c) 2015 neevtech. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "MainTabViewController.h"

@implementation CustomTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        [self initialize];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
