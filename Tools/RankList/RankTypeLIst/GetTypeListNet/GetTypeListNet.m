//
//  GetTypeListNet.m
//  网红评估工具
//
//  Created by More on 16/10/27.
//  Copyright © 2016年 More. All rights reserved.
//

#import "GetTypeListNet.h"
#import "MoreHotNewWork.h"
@implementation GetTypeListNet
+(void)getListWithapi:(NSString *)api Type:(NSDictionary *)par success:(void(^)(MoreHotModel *model))successBlock fail:(void(^)())failBlock{
    
//    http://yoursite/index.php?r=member/getclassify
    [BaseNetWork getdataWithString:api parameters:par scuccessBlock:^(NSDictionary *result) {
        NSError* err = nil;
        
        MoreHotModel *model  = [[MoreHotModel alloc]init];
        model.arr = [[NSMutableArray alloc]  init];
        for (NSDictionary *dic in result) {
            HotPersonModel *PersonMode = [[HotPersonModel alloc]initWithDictionary:dic error:&err];
            [model.arr addObject:PersonMode];
        }
        
//        NSLog(@"%@",model.arr[1].uid);
        successBlock(model);
    }fail:^{
        failBlock();
    }];
}
+(void)GetAttentionListWithPage:(NSString *)page success:(void(^)(MoreHotModel *model))successBlock fail:(void(^)())failBlock{
    
    [BaseNetWork getdataWithString:@"member/getallcollects" parameters:@{@"page":page} scuccessBlock:^(NSDictionary *result) {
        NSError* err = nil;

        MoreHotModel *model  = [[MoreHotModel alloc]init];
        model.arr = [[NSMutableArray alloc]  init];
        for (NSDictionary *dic in result) {
            HotPersonModel *PersonMode = [[HotPersonModel alloc]initWithDictionary:dic error:&err];
            [model.arr addObject:PersonMode];
        }
        
        successBlock(model);
    } fail:^{
        failBlock();
    }];
    //
}
@end
