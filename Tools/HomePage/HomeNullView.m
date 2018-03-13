//
//  HomeNullView.m
//  网红评估工具
//
//  Created by More on 16/11/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import "HomeNullView.h"

@implementation HomeNullView
+(HomeNullView *)instanceTView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HomeNullView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(void)makeUIWIthInforWithModel:(PersonnalModel *)model{
    NSString *str =[NSString stringWithFormat:@"当前共有%@名网红参与网红评估",model.usertotal];
//    /iOS6以后 在UILabel显示不同的字体和颜色
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"bf5568"] range:[str rangeOfString:model.usertotal]];

    _lastRefTime.attributedText =attstr;
    [_refBtn setTitle:@"我要估值" forState:UIControlStateNormal];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    CGFloat height =315;

    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, height );

    [_refBtn setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [_refBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"FF8481"]] forState:UIControlStateHighlighted];
    [_refBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
 
    _refBtn.layer.cornerRadius = 3;
    _refBtn.layer.borderWidth = 1;
    _refBtn.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
    _refBtn.clipsToBounds =YES;
    [_refBtn setTitle:@"我要估值" forState:UIControlStateNormal];
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
    _top1.constant = height*8;
    _top2.constant = height*12;
    _top3.constant = height*16;
    _top4.constant = height*16;
    _top5.constant = height *8  ;
    _top6.constant = height *8;
}
@end
