//
//  MoreHotCell.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MoreHotCell.h"
#import "HomeNet.h"
@implementation MoreHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImge.layer.cornerRadius = 73.5/2;
    _headImge.clipsToBounds= YES;
    
    _backView.layer.cornerRadius =5;
    _backView.clipsToBounds = YES;
    
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSString *)countNumAndChangeformat:(NSString *)num
{
    float a = 0.0;
    if (num.integerValue > 10000) {
        a = num.integerValue/10000.0;
        return [NSString stringWithFormat:@"%.2fw",a];
    }else{
        return num;
    }
    
}
-(void)configWithModel{

    [_headImge sd_setImageWithURL:[NSURL URLWithString:_model.head]  placeholderImage:[UIImage imageNamed:@"logopl"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    _NickName.text = _model.nickname;
    
    _influNumebr.text = [NSString stringWithFormat:@"当前估值:%@",[self countNumAndChangeformat: _model.valuations]];
    if(_model.tags.count==0){
        _beGoodLable.text = @"擅长领域：暂无";
    }else{
        _beGoodLable.text = [NSString stringWithFormat:@"擅长领域：%@", [_model.tags componentsJoinedByString:@" "]];
    }
    if ([_model.sex integerValue]==1) {
        [_sexBtn setImage:[UIImage imageNamed:@"女"] forState:UIControlStateNormal];
    }else{
        [_sexBtn setImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];

    }
}
- (IBAction)addAttention:(UIButton *)sender {

    if (sender.selected) {
        [SVProgressHUD showWithStatus:@"正在取消收藏"];
        [HomeNet delAttentionWithID:_model.uid success:^{
            sender.selected = !sender.selected;
//            _isattention.selected = NO;
            [[MYBaseInfo defaultManager] delAttenWIthUid:_model.uid];
            [SVProgressHUD dismiss];

        }];
    }else{
        [SVProgressHUD showWithStatus:@"正在添加收藏"];

        [HomeNet addAttentionWithID:_model.uid success:^{
//            _isattention.selected = YES;
            [[MYBaseInfo defaultManager] addAttenWIthUid:_model.uid];
            sender.selected = !sender.selected;
            [SVProgressHUD dismiss];
        }];
    }
    
    

}

@end
