//
//  RegisterDetailCell.m
//  钱转转
//
//  Created by More on 16/11/3.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RegisterDetailCell.h"
#import "ASBirthSelectSheet.h"
#import "WMZChooseSheet.h"
@implementation RegisterDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bottmLine = [[UIView alloc]init];
//                             WithFrame:CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, 1)];
        bottmLine.backgroundColor = [UIColor colorWithHexString:@"1c1c1c"];
        
        [self addSubview:bottmLine];
        [bottmLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        
        _typeLable =[[UILabel alloc]init];
        _typeLable.text = @"身份证证件";
        _typeLable.textColor = [UIColor colorWithHexString:@"ffffff"];
        _typeLable.font = [UIFont systemFontOfSize:15];
        _typeLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_typeLable];
        [_typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidthValue(40));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        
   
       
        
        
        _typeTextfield = [[UITextField alloc]init];
        _typeTextfield.placeholder =@"请输入你的出生日期";
        _typeTextfield.font = [UIFont systemFontOfSize:15];
        _typeTextfield.textAlignment = NSTextAlignmentRight;
        _typeTextfield.textColor  = [UIColor colorWithHexString:@"ffffff"];
        _typeTextfield.delegate =self;
        [self addSubview:_typeTextfield];
        [_typeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_typeLable.mas_right).offset=AdaptedWidthValue(30);
            make.right.equalTo(self.mas_right).offset = -15;
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(self.frame.size.height);
        }];
     
       
  
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}
-(void)changeValue{
    ///选择行业
    if ([_tagStr isEqualToString:@"公司所属行业"]
        ) {
        [self ChooseCpmType];
        return;
    }
    
    ///选择需求
    if ([_tagStr isEqualToString:@"商务需求"]  ) {
     
        [self ChooseBusType];
        return;

    }
    _typeTextfield.enabled = YES;
    [_typeTextfield becomeFirstResponder];

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
//    typeTitleArr = @[@"申请人姓名",@"公司名字",@"公司所属行业",@"您的职位",@"商务需求",@"联系方式"];

//    ///选择行业
//    if ([_tagStr isEqualToString:@"公司所属行业"]
//        ) {
//        [self ChooseCpmType];
//        return  NO;
//    }
//    
//    ///选择需求
//    if ([_tagStr isEqualToString:@"商务需求"]  ) {
//        [self ChooseBusType];
//        return  NO;
//    }
// 
//    
//
    return YES;
}
-(void)ChooseCpmType{
     NSArray *arr = @[@"IT/通信／互联网",@"金融行业",@"房地产／建筑",@"商业服务",@"贸易类",@"文体教育／工艺美术",@"生产／加工／制造行业",@"交通／运输／物流行业",@"服务业",@"文化／传媒行业",@"非盈利机构"];
    WMZChooseSheet *typesheet = [[WMZChooseSheet alloc] initWithFrame:[self getCurrentViewController].view .bounds];
   
    typesheet.titleStr=@"公司所属行业";
    typesheet.dataSoure = arr;
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
        _typeTextfield.text = Result;
        if(_ChangePar){
            _ChangePar(Result);
        }
    };
    [self.getCurrentViewController.view addSubview:typesheet];
}
-(void)ChooseBusType{
    NSArray *arr = @[@"电子商务合作",@"软文",@"视频",@"商业代言",@"演出经纪",@"其他"];
    WMZChooseSheet *typesheet = [[WMZChooseSheet alloc] initWithFrame:[self getCurrentViewController].view .bounds];
    
    typesheet.titleStr=@"商务需求";
    typesheet.dataSoure = arr;
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
        _typeTextfield.text = Result;

        if(_ChangePar){
            _ChangePar(Result);
        }
    };
    [self.getCurrentViewController.view addSubview:typesheet];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(_ChangePar){
        _typeTextfield.enabled = NO;

        _ChangePar(textField.text);
    }
}


@end
