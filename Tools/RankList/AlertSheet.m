//
//  AlertSheet.m
//  网红评估工具
//
//  Created by More on 16/11/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "AlertSheet.h"

static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;
@implementation AlertSheet

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)makeUIWithTitle:(NSString *)titile {
    CGFloat  width  = SCREEN_WIDTH - 60;

    if ([UILabel getWidthWithTitle:titile font:[UIFont systemFontOfSize:18]]<width) {
        width = [UILabel getWidthWithTitle:titile font:[UIFont systemFontOfSize:18]];
    }
    CGFloat height = [UILabel getHeightByWidth:width title:titile font:[UIFont systemFontOfSize:18]] + 20;
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - 250 , MainScreenWidth -40   , height)];
    _containerView.center =self.center;
    
    
    _containerView.backgroundColor =  [UIColor colorWithHexString:@"1C1C1C"];
    _containerView.layer.cornerRadius = 3;
    _containerView.layer.masksToBounds = YES;
    
    _lable= [[UILabel alloc]init];
    _lable.text  =titile;
    _lable.textColor = [UIColor whiteColor];
    _lable.center=self.center;
    _lable.numberOfLines = 0;
//    lable.bounds=CGRectMake(0, 0, SCREEN_WIDTH-600, 200);
    _lable.backgroundColor = [UIColor colorWithHexString:@"1c1c1c"];
    [_containerView addSubview:_lable];
    
    [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView.mas_centerX);
        make.centerY.equalTo(_containerView.mas_centerY);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
    [self addSubview:_containerView];

}
#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}

@end
