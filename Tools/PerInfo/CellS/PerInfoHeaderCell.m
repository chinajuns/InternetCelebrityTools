//
//  PerInfoHeaderCell.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "PerInfoHeaderCell.h"

@implementation PerInfoHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headerImageBtn.layer.cornerRadius  =SCREEN_WIDTH/3/2;
    [_headerImageBtn setClipsToBounds:YES];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
