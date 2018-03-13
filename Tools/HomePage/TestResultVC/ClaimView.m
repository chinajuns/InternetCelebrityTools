//
//  ClaimView.m
//  网红评估工具
//
//  Created by More on 16/10/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import "ClaimView.h"

@implementation ClaimView
+(ClaimView *)instanceTView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ClaimView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    _type = @"我是本人";
    _reasonTextField.layer.cornerRadius = 3;
    _reasonTextField.layer.borderWidth=1;
    _reasonTextField.layer.borderColor=[UIColor lightGrayColor].CGColor;
}
- (IBAction)mySelfPerssed:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        _agentBtn.selected = NO;
        _otherBtn.selected = NO;
        _type = @"我是本人";
    }
}
- (IBAction)agentPressed:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        _MySelfBtn.selected = NO;
        _otherBtn.selected = NO;
        _type = @"我是他／她经纪人";
    }
}
- (IBAction)otherPressed:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        _MySelfBtn.selected = NO;
        _agentBtn.selected = NO;
        _type = @"其它";
    }
}


@end
