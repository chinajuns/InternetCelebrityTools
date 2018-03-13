//
//  MisTakeView.m
//  网红评估工具
//
//  Created by More on 16/10/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MisTakeView.h"

@implementation MisTakeView
+(MisTakeView *)instanceTView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MisTakeView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    _type= @"图文不符";
    _raasonText.layer.cornerRadius = 3;
    _raasonText.layer.borderWidth=1;
    _raasonText.layer.borderColor=[UIColor lightGrayColor].CGColor;
}
- (IBAction)baseinfoPressed:(id)sender {
    if (!_baseBtn.selected) {
        _baseBtn.selected = YES;
        _rankInfoBtn.selected = NO;
        _orderBtn.selected =  NO;
        _type= @"图文不符";

    }
}
- (IBAction)rankInfoPressed:(id)sender {
    if (!_rankInfoBtn.selected) {
        _rankInfoBtn.selected = YES;
        _baseBtn.selected = NO;
        _orderBtn.selected =  NO;
        _type= @"资料有误/不完整";

    }
}
- (IBAction)orderPressed:(id)sender {
    if (!_orderBtn.selected) {
        _orderBtn.selected = YES;
        _rankInfoBtn.selected = NO;
        _baseBtn.selected =  NO;
        _type= @"排名有质疑";

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
