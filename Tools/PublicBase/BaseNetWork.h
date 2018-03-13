//
//  BaseNetWork.h
//  网红评估工具
//
//  Created by More on 16/10/21.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface BaseNetWork : NSObject

+ (void)getdataWithString:(NSString *)urlString parameters:(NSDictionary *)parameters   scuccessBlock:(void(^)(NSDictionary* result))successBlock fail:(void(^)())fiaBlock;
+ (void)postdataWithString:(NSString *)urlString parameters:(NSDictionary*)parameters   scuccessBlock:(void(^)(NSDictionary* result))successBlock;
+(void)upLoadWithImage:(UIImage *)image preGress:(void(^)(CGFloat progress))preGress  success:(void(^)(NSDictionary* result))successBlock;

/**
 登录统计
 */
+(void)loginTotal;

+(void)upLoadFileWithImage:(UIImage *)image preGress:(void(^)(CGFloat progress))preGress  success:(void(^)(NSString* result))successBlock;
@end
