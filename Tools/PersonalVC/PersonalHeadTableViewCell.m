//
//  PersonalHeadTableViewCell.m
//  网红评估工具
//
//  Created by More on 16/10/13.
//  Copyright © 2016年 More. All rights reserved.
//

#import "PersonalHeadTableViewCell.h"

@implementation PersonalHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImage.layer.cornerRadius = SCREEN_WIDTH/3/2;
    _headImage.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
