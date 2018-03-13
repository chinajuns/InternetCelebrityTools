//
//  LoginNet.m
//  网红评估工具
//
//  Created by More on 16/10/25.
//  Copyright © 2016年 More. All rights reserved.
//

#import "LoginNet.h"
@implementation LoginModel
@end
@implementation LoginNet
+(void)loginWithPhoneNumber:(NSString *)phoneNumber code:(NSString *)code successBlock:(void (^)(LoginModel *model))successBlock{

    [BaseNetWork postdataWithString:@"user/login" parameters:@{@"mobile":phoneNumber,@"code":code} scuccessBlock:^(NSDictionary *result) {
        NSError* err = nil;
        LoginModel *model  = [[ LoginModel alloc]initWithDictionary:result error:&err];
        DEF_PERSISTENT_SET_OBJECT(model.token, @"LoginToken");

        successBlock(model);
    }];
    
    
}

+(void)loginWiththirdPla:(NSDictionary *)par successBlock:(void (^)(LoginModel *model))successBlock{
    
    [BaseNetWork postdataWithString:@"user/login" parameters:par scuccessBlock:^(NSDictionary *result) {
        NSError* err = nil;
        LoginModel *model  = [[ LoginModel alloc]initWithDictionary:result error:&err];
        DEF_PERSISTENT_SET_OBJECT(model.token, @"LoginToken");
        
        successBlock(model);
    }];
    
    
}
+(void)loginWithPlatform:(NSString *)platform openID:(NSString *)openid successBlock:(void (^)(NSDictionary *model))successBlock{
    //qq weixin  weibo
    [BaseNetWork postdataWithString:@"user/thirdlogin" parameters:@{@"openid":openid,@"platform":platform} scuccessBlock:^(NSDictionary *result) {
        successBlock(result);
    }];
    
    
}
@end
