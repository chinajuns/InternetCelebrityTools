//
//  MoreHotNewWork.m
//  网红评估工具
//
//  Created by More on 16/10/25.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MoreHotNewWork.h"

@implementation HotPersonModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end

@implementation MoreHotModel


@end
@implementation MoreHotNewWork
+(void)getListWithType:(NSString *)Type success:(void(^)(MoreHotModel *model))successBlock{

    [BaseNetWork postdataWithString:@"member/getrecommend" parameters:@{@"tpye":Type} scuccessBlock:^(NSDictionary *result) {
        NSError* err = nil;

        MoreHotModel *model  = [[MoreHotModel alloc]init];
        model.arr = [[NSMutableArray alloc]  init];
        for (NSDictionary *dic in result) {
            HotPersonModel *PersonMode = [[HotPersonModel alloc]initWithDictionary:dic error:&err];
            [model.arr addObject:PersonMode];
        }
        
        successBlock(model);
    }];
}
+(void)addAttentionWIthIDArr:(NSArray *)Idarr success:(void(^)())successBlock{
    [SVProgressHUD show];

    [BaseNetWork postdataWithString:@"member/set-more-fans" parameters:@{@"uid":Idarr} scuccessBlock:^(NSDictionary *result) {
        successBlock();
    }];
    
}
@end
