//
//  MistakeActionSheet.m
//  网红评估工具
//
//  Created by More on 16/10/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MistakeActionSheet.h"
#import "MisTakeView.h"
#import "PersonalInfoNet.h"
static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;
static CGFloat height = 370;
@interface MistakeActionSheet (){
    MisTakeView  *view;
}

@end
@implementation MistakeActionSheet

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    
    view = [MisTakeView instanceTView];
    view.bounds  = CGRectMake(0,0, MainScreenWidth - 20, height);;
    view.center = CGPointMake( MainScreenWidth/2,(MainScreenHeight+64)/2);
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [view.subMitBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:view];
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (view.raasonText.text.length ==0) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入错误信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    if (self.GetSelectDate) {
        NSDictionary *dic;
        _GetSelectDate(dic);
        [SVProgressHUD show];

        [PersonalInfoNet submitMistakeWithPar:@{@"type":view.type,@"content":view.raasonText.text,@"uid":_uid} success:^{
            [self removeFromSuperview];
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

- (void)dateChange:(id)datePicker {
    
}

@end
