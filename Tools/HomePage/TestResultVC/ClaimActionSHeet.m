//
//  ClaimActionSHeet.m
//  网红评估工具
//
//  Created by More on 16/10/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import "ClaimActionSHeet.h"
#import "ClaimView.h"
#import "PersonalInfoNet.h"
static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;
static CGFloat height = 470;

@interface ClaimActionSHeet(){
    ClaimView  *view;
}


@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end
@implementation ClaimActionSHeet
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
    
   view = [ClaimView instanceTView];
    view.bounds  = CGRectMake(0,0, MainScreenWidth - 20, height);;
    view.center = CGPointMake( MainScreenWidth/2,(MainScreenHeight+64)/2);

    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [view.submitBrn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:view];
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//手机号码验证
-(BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
- (void)doneAction:(UIButton *)btn {
        if (view.phoneNumber.text.length ==0) {
            if([self isValidateEmail:view.phoneNumber.text] || [self validateMobile:view.phoneNumber.text]){
                
            }else{
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的联系方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertview show];
                return;
            }
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的联系方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertview show];
            return;
        }else{
            if([self isValidateEmail:view.phoneNumber.text] || [self validateMobile:view.phoneNumber.text]){
                
            }else{
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的联系方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertview show];
                return;
            }
        }
    if (view.reasonTextField.text.length ==0) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入认领理由" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    if (self.GetSelectDate) {
        NSDictionary *dic;
        _GetSelectDate(dic);
        [SVProgressHUD show];
        [PersonalInfoNet setclaimWithPar:@{@"type":view.type,@"contact":view.phoneNumber.text,@"reason":view.reasonTextField.text,@"uid":_uid} success:^{
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




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
