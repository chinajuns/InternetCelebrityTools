//
//  OtherIDTableViewCell.m
//  网红评估工具
//
//  Created by More on 16/10/8.
//  Copyright © 2016年 More. All rights reserved.
//

#import "OtherIDTableViewCell.h"

@implementation OtherIDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
        _firstPl=  [ThirdPLNameAndID instanceTView];
        _firstPl.frame   = CGRectMake(0, 0, self.bounds.size.width, 70);
        _firstPl.backgroundColor = [UIColor clearColor];
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
        _firstPl.IDTextField.leftView = leftView;
        _firstPl.IDTextField.leftViewMode = UITextFieldViewModeAlways;
        _firstPl.IDTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _firstPl.IDTextField.layer.cornerRadius = 8 ;
        _firstPl.IDTextField.clipsToBounds = YES;
        [self addSubview:_firstPl];
        
        _sconedPl=  [ThirdPLNameAndID instanceTView];
        _sconedPl.frame   = CGRectMake(0, 70, self.bounds.size.width, 70);
        _sconedPl.backgroundColor = [UIColor clearColor];
        UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView1.backgroundColor = [UIColor clearColor];
        _sconedPl.IDTextField.leftView = leftView1;
        _sconedPl.IDTextField.leftViewMode = UITextFieldViewModeAlways;
        _sconedPl.IDTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _sconedPl.IDTextField.layer.cornerRadius = 8 ;
        _sconedPl.IDTextField.clipsToBounds = YES;
        [self addSubview:_sconedPl];
        
        _thirdPl=  [ThirdPLNameAndID instanceTView];
        _thirdPl.frame   = CGRectMake(0, 70*2, self.bounds.size.width, 70);
        _thirdPl.backgroundColor = [UIColor clearColor];
        UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView2.backgroundColor = [UIColor clearColor];
        _thirdPl.IDTextField.leftView = leftView2;
        _thirdPl.IDTextField.leftViewMode = UITextFieldViewModeAlways;
        _thirdPl.IDTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _thirdPl.IDTextField.layer.cornerRadius = 8 ;
        _thirdPl.IDTextField.clipsToBounds = YES;
        [self addSubview:_thirdPl];
        
        
    }
-(NSDictionary *)getHZInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc ]init];
    NSArray * typePYArr = @[@"weixin",@"weibo",@"meipai",@"miaopai",@"yinke",@"bilibili"];
    NSArray *typeArr  = @[@"微信公众号",@"新浪微博",@"美拍",@"秒拍",@"映客",@"bilibili"];
    
    
    if (_firstPl.IDTextField.text.length>0&& _firstPl.hidden == NO
        ) {
       
            [dic setObject:_firstPl.IDTextField.text forKey:_firstPl.titleLable.text];
            
    }
    if (_sconedPl.IDTextField.text.length>0 && _sconedPl.hidden == NO ) {
      
            [dic setObject:_sconedPl.IDTextField.text forKey:_sconedPl.titleLable.text];
            
    }
    if (_thirdPl.IDTextField.text.length>0 && _thirdPl.hidden == NO ) {
  
            [dic setObject:_thirdPl.IDTextField.text forKey:_thirdPl.titleLable.text];
            
    }
    return dic;
}
-(NSDictionary *)getInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc ]init];
   NSArray * typePYArr = @[@"weixin",@"weibo",@"meipai",@"miaopai",@"yinke",@"bilibili"];
    NSArray *typeArr  = @[@"微信公众号",@"新浪微博",@"美拍",@"秒拍",@"映客",@"bilibili"];
    
    
    if (_firstPl.IDTextField.text.length>0&& _firstPl.hidden == NO) {
        
        if ([typeArr containsObject:_firstPl.titleLable.text]) {
            NSInteger index = [typeArr indexOfObject:_firstPl.titleLable.text];
            [dic setObject:_firstPl.IDTextField.text forKey:typePYArr[index]];

        }else{
            [dic setObject:_firstPl.IDTextField.text forKey:_firstPl.titleLable.text];

        }
    }
    if (_sconedPl.IDTextField.text.length>0 && _sconedPl.hidden == NO ) {
        if ([typeArr containsObject:_sconedPl.titleLable.text]) {
            NSInteger index = [typeArr indexOfObject:_sconedPl.titleLable.text];
            [dic setObject:_sconedPl.IDTextField.text forKey:typePYArr[index]];
            
        }else{
            [dic setObject:_sconedPl.IDTextField.text forKey:_sconedPl.titleLable.text];
            
        }
    }
    if (_thirdPl.IDTextField.text.length>0 && _thirdPl.hidden == NO ) {
        if ([typeArr containsObject:_thirdPl.titleLable.text]) {
            NSInteger index = [typeArr indexOfObject:_thirdPl.titleLable.text];
            [dic setObject:_thirdPl.IDTextField.text forKey:typePYArr[index]];
            
        }else{
            [dic setObject:_thirdPl.IDTextField.text forKey:_thirdPl.titleLable.text];
            
        }
    }
    return dic;
}
-(void)refreaUIWithPlsArr:(NSArray *)arr{
    if (arr.count==0) {
        _firstPl.hidden = YES;
        _sconedPl.hidden = YES;
        _thirdPl.hidden = YES;
    }
    if (arr.count==1) {
        _firstPl.hidden = NO;
        _firstPl.titleLable.text = arr[0];
        if([arr[0] isEqualToString:@"新浪微博"] ){
            _firstPl.IDTextField.placeholder=@"请点击上方认证按钮，认证";

            _firstPl.configBtn.hidden = NO;
            _firstPl.IDTextField .enabled =NO;
            _firstPl.IDTextField.backgroundColor = [UIColor clearColor];
        }else{
            _firstPl.configBtn.hidden = YES;
            _firstPl.IDTextField .enabled =YES;
            _firstPl.IDTextField.backgroundColor = [UIColor colorWithHexString:@"FF8481"];

        }
        
        if([_nameAndId objectForKey:arr[0]]){
            _firstPl.IDTextField.text = [_nameAndId objectForKey:arr[0]];
        }
        _sconedPl.hidden = YES;
        _thirdPl.hidden = YES;    }
    
    if (arr.count==2) {
        _firstPl.hidden = NO;
    
        _sconedPl.hidden = NO;
        _thirdPl.hidden = YES;
        _firstPl.titleLable.text = arr[0];
        if([arr[0] isEqualToString:@"新浪微博"] ){
            _firstPl.configBtn.hidden = NO;
            _firstPl.IDTextField .enabled =NO;
            _firstPl.IDTextField.backgroundColor = [UIColor clearColor];
            _firstPl.IDTextField.placeholder=@"请点击上方认证按钮，认证";

        }else{
            _firstPl.configBtn.hidden = YES;
            _firstPl.IDTextField .enabled =YES;
            _firstPl.IDTextField.backgroundColor = [UIColor colorWithHexString:@"FF8481"];

        }
        _sconedPl.titleLable.text = arr[1];
        if([_nameAndId objectForKey:arr[0]]){
            _firstPl.IDTextField.text = [_nameAndId objectForKey:arr[0]];
        }
        
        if([arr[1] isEqualToString:@"新浪微博"] ){
            _sconedPl.IDTextField.backgroundColor = [UIColor clearColor];
            _sconedPl.IDTextField.placeholder=@"请点击上方认证按钮，认证";

            _sconedPl.configBtn.hidden = NO;
            _sconedPl.IDTextField .enabled =NO;
        }else{
            _sconedPl.configBtn.hidden = YES;
            _sconedPl.IDTextField .enabled =YES;
            _sconedPl.IDTextField.backgroundColor = [UIColor colorWithHexString:@"FF8481"];

        }
        if([_nameAndId objectForKey:arr[1]]){
            _sconedPl.IDTextField.text = [_nameAndId objectForKey:arr[1]];
        }

    }
    if (arr.count==3) {
        _firstPl.hidden = NO;
        _sconedPl.hidden = NO;
        _thirdPl.hidden = NO;
        _firstPl.titleLable.text = arr[0];
        _sconedPl.titleLable.text = arr[1];
        _thirdPl.titleLable.text = arr[2];
        
        if([arr[0] isEqualToString:@"新浪微博"] ){
            _firstPl.configBtn.hidden = NO;
            _firstPl.IDTextField .enabled =NO;
            _firstPl.IDTextField.placeholder=@"请点击上方认证按钮，认证";

        }else{
            _firstPl.IDTextField .enabled =YES;
            _firstPl.IDTextField.backgroundColor = [UIColor colorWithHexString:@"FF8481"];

            _firstPl.configBtn.hidden = YES;
        }
        if([_nameAndId objectForKey:arr[0]]){
            _firstPl.IDTextField.text = [_nameAndId objectForKey:arr[0]];
        }
        
        
        
        if([arr[1] isEqualToString:@"新浪微博"] ){
            _sconedPl.configBtn.hidden = NO;
            _sconedPl.IDTextField.placeholder=@"请点击上方认证按钮，认证";
            _sconedPl.IDTextField .enabled =NO;
            _sconedPl.IDTextField.backgroundColor = [UIColor clearColor];

        }else{
            _sconedPl.IDTextField.backgroundColor = [UIColor colorWithHexString:@"FF8481"];

            _sconedPl.IDTextField .enabled =YES;
            _sconedPl.configBtn.hidden = YES;
        }
        if([_nameAndId objectForKey:arr[1]]){
            _sconedPl.IDTextField.text = [_nameAndId objectForKey:arr[1]];
        }
        
        
        if([arr[2] isEqualToString:@"新浪微博"] ){
            _thirdPl.IDTextField.placeholder=@"请点击上方认证按钮，认证";
            _thirdPl.IDTextField.backgroundColor = [UIColor clearColor];

            _thirdPl.configBtn.hidden = NO;
            _thirdPl.IDTextField .enabled =NO;

        }else{
            _thirdPl.IDTextField .enabled =YES;
            _thirdPl.IDTextField.backgroundColor = [UIColor colorWithHexString:@"FF8481"];

            _thirdPl.configBtn.hidden = YES;
        }
        if([_nameAndId objectForKey:arr[2]]){
            _thirdPl.IDTextField.text = [_nameAndId objectForKey:arr[2]];
        }

    }
    
    
}   // Configure the view for the selected state
@end
