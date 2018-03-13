//
//  RankTypeTableViewCell.m
//  网红评估工具
//
//  Created by More on 16/9/29.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RankTypeTableViewCell.h"
#import "MYButton.h"
@implementation RankTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat width  =SCREEN_WIDTH/5;
    NSArray *types = @[@"时尚",@"美食",@"搞笑",@"娱乐",@"明星",@"游戏",@"旅游",@"健康",@"宠物",@"科技"];
    NSArray *iamgeTypes = @[@"图层-32",@"图层-33",@"侧边脸笑",@"图层-34",@"图层-35",@"图层-37",@"图层-38",@"图层-39",@"图层-40",@"科技"];

    for (int i  = 0;i <10; i++  ) {
        MYButton *button = [[MYButton alloc]initWithFrame:CGRectMake(i%5*width, 10+i/5*width, width, width  )];
        [button setImage:[UIImage imageNamed:iamgeTypes[i]] forState:UIControlStateNormal];
        [button setTitle:types[i] forState:UIControlStateNormal];
        button.imageView.layer.cornerRadius  = width/3;
        button.imageView.clipsToBounds = YES;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(typeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    // Initialization code
}
-(void)typeBtnPressed:(UIButton *)button{
    [self.typeDelegate typeBtnPressed:button];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
