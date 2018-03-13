//
//  ASBirthSelectSheet.m
//  ASBirthSheet
//
//  Created by Ashen on 15/12/8.
//  Copyright © 2015年 Ashen. All rights reserved.
//

#import "ASBirthSelectSheet.h"
#import <UIKit/UIKit.h>

static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;


@interface ASBirthSelectSheet()


@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end
@implementation ASBirthSelectSheet

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
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - 250 , MainScreenWidth, 200)];
    _containerView.backgroundColor = [UIColor colorWithHexString:@"1C1C1C"];
    _containerView.layer.cornerRadius = 3;
    _containerView.layer.masksToBounds = YES;
    _datePicker =  [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, MainScreenWidth, 150)];
    [_datePicker setDate:[NSDate date] animated:YES];
    [_datePicker setMaximumDate:[NSDate date]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    _datePicker.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [_datePicker setMinimumDate:[self.formatter dateFromString:@"1940-01-01日"]];
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [_containerView addSubview:_datePicker];
    
    

    
    

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 50)];
    label.text = @"生日";
    label.textColor = [UIColor whiteColor];
    [_containerView addSubview:label];
    
    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDone.frame = CGRectMake(SCREEN_WIDTH-66, 0, 50, 50);
    _btnDone.titleLabel.font = [UIFont systemFontOfSize:20];
    [_btnDone setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [_btnDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnDone];
    
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCancel.frame =   CGRectMake(SCREEN_WIDTH-66-66, 0, 50 , 50) ;
    _btnCancel.titleLabel.font = [UIFont systemFontOfSize:20];

    [_btnCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnCancel];
    
    [self addSubview:_containerView];
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}


#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.GetSelectDate) {
        _GetSelectDate([self.formatter stringFromDate:_datePicker.date]);
        [self removeFromSuperview];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

- (void)dateChange:(id)datePicker {
    
}

#pragma mark - setter、getter
- (void)setSelectDate:(NSString *)selectDate {
    [_datePicker setDate:[self.formatter dateFromString:selectDate] animated:YES];
}
- (NSDateFormatter *)formatter {
    if (_formatter) {
        return _formatter;
    }
    _formatter =[[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    return _formatter;
    
}

@end
