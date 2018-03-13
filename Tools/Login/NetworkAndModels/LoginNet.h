//
//  LoginNet.h
//  网红评估工具
//
//  Created by More on 16/10/25.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LoginModel : JSONModel
@property (strong, nonatomic) NSString* isfirst;
@property (assign, nonatomic) NSString* token;
@end


@interface LoginNet : NSObject
+(void)loginWithPhoneNumber:(NSString *)phoneNumber code:(NSString *)code successBlock:(void(^)(LoginModel *model))successBlock;
+(void)loginWithPlatform:(NSString *)platform openID:(NSString *)openid successBlock:(void (^)(NSDictionary *model))successBlock;
+(void)loginWiththirdPla:(NSDictionary *)par successBlock:(void (^)(LoginModel *model))successBlock;

@end
