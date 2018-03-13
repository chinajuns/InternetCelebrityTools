//
//  RankMoreInfoTableViewCell.m
//  网红评估工具
//
//  Created by More on 16/10/14.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RankMoreInfoTableViewCell.h"

@implementation RankMoreInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    FF8481  F2DB4D
//    _addAttention.layer.cornerRadius = 3;
//    _addAttention.clipsToBounds = YES;
//    _addAttention.layer.borderWidth=1;
//    _addAttention.layer.borderColor = [UIColor colorWithHexString:@"F2DB4D"].CGColor;
//    
    
    
    _moreInfoBtn.layer.cornerRadius = 3;
    _moreInfoBtn.clipsToBounds = YES;
    _moreInfoBtn.layer.borderWidth=1;
    _moreInfoBtn.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;

    
    _pinkView.layer.cornerRadius= 3;
    _pinkView.clipsToBounds = YES;
    
    
    _purpleView.layer.cornerRadius= 3;
    _purpleView.clipsToBounds = YES;
    
    _yellowView.layer.cornerRadius= 4;
    _yellowView.clipsToBounds = YES;
    // Initialization code
}
-(void)configWithModel:(PersonnalModel *)model{
    _nickNameLable.text = model.nickname;
//    _sexAndAgeBtn
    NSString *bir = [self formateDateNum:model.birthday withFormateStr:@"yyyy-MM-dd"];
    if (![bir isEqualToString:@"1970-01-01"]) {
        NSInteger age =   [self ageWithDateOfBirth:[self formateDateNum:model.birthday    withFormateStr:@"yyyy-MM-dd"]];
        if(age==0){
            [_sexAndAgeBtn setTitle:@" 保密" forState:UIControlStateNormal];
            
            _ageLable.text = @"保密" ;

        }else{
            [_sexAndAgeBtn setTitle:[NSString stringWithFormat:@"  %ld",(long)age] forState:UIControlStateNormal];
            
            _ageLable.text = [NSString stringWithFormat:@"%ld",(long)age] ;

        }
     
    }else{
        [_sexAndAgeBtn setTitle:@" 保密" forState:UIControlStateNormal];
        _ageLable.text = @"保密" ;
        


    }
    if ([model.sex  integerValue]==0) {
        [_sexAndAgeBtn setImage:[UIImage imageNamed:@"女"] forState:UIControlStateNormal];
    }else{
        [_sexAndAgeBtn setImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];
 
    }
    
    if([model.height integerValue]==0){
        _heightLable.text = @"保密";
    }else{
        _heightLable.text = [NSString stringWithFormat:@"%@cm",model.height];
 
    }
    if([model.weight integerValue]==0){
        _weightLable.text = @"保密";
    }else{
        _weightLable.text = [NSString stringWithFormat:@"%@kg",model.weight];
    }
    if ([model.bust integerValue] ==0 || [model.waistline integerValue]==0 || [model.hipline integerValue]== 0) {
          _shapeLable.text = @"保密";
    }else{
        _shapeLable.text =[NSString stringWithFormat:@"%@ %@ %@",model.bust,model.waistline,model.hipline];
   
    }
    _beGoodAtLable.text = [NSString stringWithFormat:@"%@",[model.tags componentsJoinedByString:@" "] ];
    if (model.live_city.length>0) {
        _cityLable.text = [NSString stringWithFormat:@"%@%@",model.live_province,model.live_city];
        [_cityBtn setTitle:model.live_city forState:UIControlStateNormal];

    }else{
        _cityLable.text = @"保密";
        [_cityBtn setTitle:@"保密" forState:UIControlStateNormal];

    }
 
    if([model.influence_ranking integerValue]>=20000){
        _rankNumberLable.text = @"暂未上榜";
        
    }else{
        _rankNumberLable.text = model.influence_ranking;
        
    }
  
    NSInteger change = [model.influence_ranking  integerValue]-[model.old_influence_ranking integerValue];
    [_rankChangeLable setTitle:[NSString stringWithFormat:@"%ld",labs(change)] forState:UIControlStateNormal]; ;

//    _rankChangeLable
 
    _refreaTimeLable.text = [NSString stringWithFormat:@"更新于:%@", [self formateDateNum:  [model.update_time integerValue] withFormateStr:@"yyyy-MM-dd"]];
    _priceLable.text = [NSString stringWithFormat:@"%@",[self countNumAndChangeformat:model.valuations]];
    if (model.business.count>0) {
        _accpetTypeLable.text = [model.business  componentsJoinedByString:@" "];

    }else{
        _accpetTypeLable.text =   @"保密";
    }
    
    _commercial.text =[NSString stringWithFormat:@"%ld分",(long)[model.commercial integerValue]];
    _glamorousLable.text =[NSString stringWithFormat:@"%ld分",(long)[model.glamorous integerValue]];
    _influLable.text =[NSString stringWithFormat:@"%ld分",(long)[model.influence integerValue]];
    
    NSMutableArray *arr  = [[MYBaseInfo defaultManager] refreash];
    if ([arr containsObject:_datamodel.uid]) {
      _addAttention.selected = YES;
    }else{
        _addAttention.selected = NO;
    }

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addAttention:(UIButton *)sender {
    sender.selected = !sender.selected;
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
- (NSInteger)ageWithDateOfBirth:(NSString *)bir;
{
//    NSString *string = @"2016-7-16 09:33:22";
    
    // 日期格式化类
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    
    format.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    
    NSDate *date = [format dateFromString:bir];
    
//    NSString *newString = [format stringFromDate:data];

    
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    NSLog(@" %@  年龄  %ld",bir,(long)iAge);

    return iAge;
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
@end
