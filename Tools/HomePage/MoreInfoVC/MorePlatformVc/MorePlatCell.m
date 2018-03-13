//
//  MorePlatCell.m
//  网红评估工具
//
//  Created by More on 16/10/31.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MorePlatCell.h"
#import "ThirdPLNameAndID.h"
@implementation MorePlatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _thirdPla=  [ThirdPLNameAndID instanceTView];
    _thirdPla.frame   = CGRectMake(0, 0, SCREEN_WIDTH, 95);
    _thirdPla.backgroundColor = [UIColor clearColor];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    _thirdPla.IDTextField.leftView = leftView;
    _thirdPla.IDTextField.leftViewMode = UITextFieldViewModeAlways;
    _thirdPla.IDTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:_thirdPla];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
