//
//  PersonalInfoNet.m
//  网红评估工具
//
//  Created by More on 16/10/26.
//  Copyright © 2016年 More. All rights reserved.
//

#import "PersonalInfoNet.h"
#import "HomeNet.h"
@implementation PersonalInforDetailModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
@implementation PersonalInfoNet
+(void)getMoreInforMationWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock{
    [BaseNetWork postdataWithString:@"member/setdatum" parameters:parmeter scuccessBlock:^(NSDictionary *result) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,资料我们已收到，请耐心等待客服联系！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertview show];
        successBlock();
    }];
}

+(void)submitMistakeWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock{
    [BaseNetWork postdataWithString:@"member/seterror" parameters:parmeter scuccessBlock:^(NSDictionary *result) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"感谢您的宝贵意见，我们会尽快处理！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertview show];
        successBlock();

    }];
}
+(void)setclaimWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock{
   [BaseNetWork postdataWithString:@"member/setclaim"  parameters:parmeter scuccessBlock:^(NSDictionary *result) {
       UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,资料我们已收到，请耐心等待客服联系！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
       [alertview show];
       successBlock();
 
    }];
}

+(void)haveCoorWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock{
    [BaseNetWork postdataWithString:@"member/setbusiness"  parameters:parmeter scuccessBlock:^(NSDictionary *result) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,资料我们已收到，请耐心等待客服联系！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertview show];
        successBlock();
 
    }];
}
+(void)getUserInfoDetailWithUid:(NSString *)uid Success:(void(^)(PersonalInforDetailModel *model))succexxblock fainBlock:(void(^)())failBlock{

    [BaseNetWork getdataWithString:@"member/userdetail" parameters:@{@"uid":uid} scuccessBlock:^(NSDictionary *result) {
        NSError* err = nil;
        PersonalInforDetailModel *model = [[PersonalInforDetailModel alloc]initWithDictionary:result error:&err];
        succexxblock(model);
    } fail:^{
        failBlock();
    }];
}
@end
