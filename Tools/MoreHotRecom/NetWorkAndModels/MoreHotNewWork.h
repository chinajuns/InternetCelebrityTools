//
//  MoreHotNewWork.h
//  网红评估工具
//
//  Created by More on 16/10/25.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface HotPersonModel : JSONModel
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *head;
@property(nonatomic,assign)int influence;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSArray *tags;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *valuations;


@end
@interface MoreHotModel : JSONModel
@property(nonatomic,strong)NSMutableArray<HotPersonModel *> *arr;

@end
@interface MoreHotNewWork : NSObject
+(void)getListWithType:(NSString *)Type success:(void(^)(MoreHotModel *model))successBlock;
+(void)addAttentionWIthIDArr:(NSArray *)Idarr success:(void(^)())successBlock;

@end
