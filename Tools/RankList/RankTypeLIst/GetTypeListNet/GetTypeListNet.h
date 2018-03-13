//
//  GetTypeListNet.h
//  网红评估工具
//
//  Created by More on 16/10/27.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreHotNewWork.h"

@interface GetTypeListNet : NSObject
+(void)getListWithapi:(NSString *)api Type:(NSDictionary *)par success:(void(^)(MoreHotModel *model))successBlock fail:(void(^)())failBlock;
+(void)GetAttentionListWithPage:(NSString *)page success:(void(^)(MoreHotModel *model))successBlock fail:(void(^)())failBlock;

@end
