//
//  HomeHasView.m
//  网红评估工具
//
//  Created by More on 16/9/29.
//  Copyright © 2016年 More. All rights reserved.
//

#import "HomeHasView.h"
#import "UMSocialUIManager.h"

@implementation HomeHasView
+(HomeHasView *)instanceTView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HomeHasView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)ResetHeight:(CGFloat)height{
    _top1.constant = height*12;
    _top2.constant = height*12;
    _top3.constant = height*12;
    _top4.constant = height*12;
    _top5.constant = height *9  ;
    _top6.constant = height *16;
    _top7.constant = height *8;
    _width1.constant = SCREEN_WIDTH/320.0*40;
    _width2.constant = SCREEN_WIDTH/320.0*30;
    _width3.constant = SCREEN_WIDTH/320.0*55;


}
-(void)awakeFromNib{
    [super awakeFromNib];
    _isfinsh =YES;
    [_refBtn setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [_refBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"FF8481"]] forState:UIControlStateHighlighted];
    [_refBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    _headImage.layer.cornerRadius=SCREEN_WIDTH/4/2.0;
    _headImage.clipsToBounds =YES;
    
    _confBtn.layer.cornerRadius = 3;
    _refBtn.clipsToBounds =YES;
    _confBtn.layer.borderWidth = 1;
    _confBtn.layer.borderColor = [UIColor colorWithHexString:@"F2DB4D"].CGColor;;
    
    _refBtn.layer.cornerRadius = 3;
    _refBtn.clipsToBounds =YES;
//    _refBtn.layer.borderWidth = 1;
//    _refBtn.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
    _refBtn.clipsToBounds =YES;
       [_refBtn setTitle:@"我要估值" forState:UIControlStateNormal];
    _confBtn.hidden= YES;
    
    _totalRankNumberLable.text = @"－ －";
    _totalChangeNumber.hidden =YES;
    _totalDIreCtionImageView.hidden  = YES;
    
    _impLable.text  = @"魅力值 －－ ";
    _imChangeBtn.hidden = YES;
    
    _inflauceBtn.hidden =YES;
    _influeceLable.text  = @"影响力 －－ ";
    
    _busiBtn.hidden = YES;
    _busiLable.text = @"商业值 －－ ";
    
    _currLable.text = @"当前估值 －－ ";
    
    [_refBtn setTitle:@"我要估值" forState:UIControlStateNormal];
    
    
}

-(void)animations{
    if  (!_isfinsh){
        return;
    }
    _isfinsh=NO;
    [UIView animateWithDuration:0.3 animations:^{
        _impLable.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _impLable.transform = CGAffineTransformMakeScale(1, 1);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _influeceLable.transform = CGAffineTransformMakeScale(1.5, 1.5);
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    _influeceLable.transform = CGAffineTransformMakeScale(1, 1);
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        _busiLable.transform = CGAffineTransformMakeScale(1.5, 1.5);
                    }completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            _busiLable.transform = CGAffineTransformMakeScale(1, 1);
                        }completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.3 animations:^{
                                _currLable.transform = CGAffineTransformMakeScale(1.5, 1.5);
                            }completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.3 animations:^{
                                    _currLable.transform = CGAffineTransformMakeScale(1, 1);
                                }completion:^(BOOL finished) {
                                    _isfinsh=YES;

                                    
                                }];
                                
                            }];
                            
                        }];
                        
                    }];
                    
                }];
                
            }];
            
        }];

    }];
}
-(void)makeUIWIthInforWithModel:(PersonnalModel *)model{
//    _alertLableOne.hidden =YES;
//    _alertLableTwo.hidden  = YES;
//    _alertLableThree.hidden = YES;
    
    NSInteger change = 0;
    if([model.influence_ranking integerValue]>=20000){
        _totalRankNumberLable.text = @"暂未上榜";

    }else{
        _totalRankNumberLable.text = model.influence_ranking;

    }
   change = [model.influence_ranking  integerValue]-[model.old_influence_ranking integerValue];
    _totalChangeNumber.text= [NSString stringWithFormat:@"%ld名",labs(change)];
//    if (change>=0) {
//        [_totalDIreCtionImageView setImage:[UIImage imageNamed:@"上升"] forState:UIControlStateNormal];
//    }else{
//        [_totalDIreCtionImageView setImage:[UIImage imageNamed:@"下降-(1)"] forState:UIControlStateNormal];
//    }
    _totalRankNumberLable.hidden = NO;
    _totalChangeNumber.hidden = NO;

    _totalDIreCtionImageView.hidden = NO;

    _impLable.text  = [NSString stringWithFormat:@"魅力值%@分",model.glamorous];
    change = [model.glamorous  integerValue]-[model.old_glamorous integerValue];
    if (change>=0) {
            [_imChangeBtn setTitle:[NSString stringWithFormat:@"＋%ld",labs(change)] forState:UIControlStateNormal];
    }else{
            [_imChangeBtn setTitle:[NSString stringWithFormat:@"－%ld",labs(change)] forState:UIControlStateNormal];
    }

    _imChangeBtn.hidden = NO;

    
    
    _influeceLable.text  =[NSString stringWithFormat:@"影响力%@分",model.influence];
    change = [model.influence  integerValue]-[model.old_influence integerValue];
    if (change>=0) {
        [_inflauceBtn setTitle:[NSString stringWithFormat:@"＋%ld",labs(change)] forState:UIControlStateNormal];


    }else{
        [_inflauceBtn setTitle:[NSString stringWithFormat:@"－%ld",labs(change)] forState:UIControlStateNormal];

    }
    _inflauceBtn.hidden = NO;

    
    _busiBtn.hidden = NO;
    _busiLable.text = [NSString stringWithFormat:@"商业值%@分",model.commercial];
    change = [model.commercial  integerValue]-[model.old_commercial integerValue];
    if (change>=0) {
        [_busiBtn setTitle:[NSString stringWithFormat:@"＋%ld",labs(change)] forState:UIControlStateNormal];

    }else{
        [_busiBtn setTitle:[NSString stringWithFormat:@"－%ld",labs(change)] forState:UIControlStateNormal];

    }
    NSString *str =[NSString stringWithFormat:@"当前估值%@元",model.valuations];
    //    /iOS6以后 在UILabel显示不同的字体和颜色
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"bf5568"] range:[str rangeOfString:model.valuations]];
    _currLable.attributedText =attstr;
//    @"当前估值 －－ ";
    
    
    
    
    
    
    if([model.is_authentication integerValue]==0){
        _confBtn.selected = NO;
        _confBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;;
    }else{
        _confBtn.selected = YES;
        _confBtn.layer.borderColor = [UIColor colorWithHexString:@"F2DB4D"].CGColor;;
    }
    
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"logopl"]];
    _nickNameLbale.text  = model.nickname;
    _lastRefTime.text =[NSString stringWithFormat:@"数据更新于%@",model.update_time];
    [_refBtn setTitle:@"一键刷新" forState:UIControlStateNormal];
    [self animations];

}
-(NSString *)formateDateNum:(NSInteger) dateNum withFormateStr:(NSString *)formatstr
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:formatstr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/chongqing"];
    [formater setTimeZone:timeZone];
    NSString *dateStr = [formater stringFromDate:date];
    return dateStr;
}


@end
