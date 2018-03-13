//
//  MessageNet.m
//  网红评估工具
//
//  Created by More on 16/11/1.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MessageNet.h"
#import "BaseNetWork.h"
@implementation MessageModel
@end
@implementation MessageNet
+(void)getallMessagePar:(NSDictionary *)par success:(void(^)(NSArray<MessageModel *> *arr))successBlock{
    [BaseNetWork getdataWithString:@"member/getmessage" parameters:nil scuccessBlock:^(NSDictionary *result) {
        NSError *err;
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in result) {
           
            [arr addObject: [[MessageModel alloc]initWithDictionary:dic error:&err]];
        }
        successBlock(arr);
    } fail:^{
        
    }];
}@end
