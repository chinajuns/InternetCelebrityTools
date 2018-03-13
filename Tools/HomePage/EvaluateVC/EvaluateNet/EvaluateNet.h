//
//  EvaluateNet.h
//  网红评估工具
//
//  Created by More on 16/10/26.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreHotNewWork.h"
@interface EvaluateNet : NSObject
+(void)submitPerinfo:(NSDictionary *)par  Success:(void(^)(NSArray <HotPersonModel *> *date))successBlock;
@end
