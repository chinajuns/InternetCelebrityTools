//
//  HomeNet.m
//  网红评估工具
//
//  Created by More on 16/10/26.
//  Copyright © 2016年 More. All rights reserved.
//

#import "HomeNet.h"
@implementation PersonnalModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
@implementation HomeNet
+(void)getInfomationSuccess:(void(^)(PersonnalModel *model))succexxblock{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    NSLog(@"%@",DEF_PERSISTENT_GET_OBJECT(@"LoginToken"));
    
    [BaseNetWork getdataWithString:@"member/getcomprofile" parameters:nil scuccessBlock:^(NSDictionary *result) {
        NSError* err = nil;
        PersonnalModel *model = [[PersonnalModel alloc]initWithDictionary:result error:&err];
        model.update_time = dateString;
        if (DEF_PERSISTENT_GET_OBJECT(@"LastTime")) {
            model.update_time = DEF_PERSISTENT_GET_OBJECT(@"LastTime");
        }else{
            model.update_time  = dateString;
        }
        DEF_PERSISTENT_SET_OBJECT(dateString, @"LastTime");

        succexxblock(model);
    } fail:^{
        
    }];
}
+(void)addAttentionWithID:(NSString *)ID success:(void(^)())successBlock{
//    [BaseNetWork postdataWithString:@"member/setfans" parameters:@{@"uid":ID} scuccessBlock:^(NSDictionary *result) {
//       
//        successBlock();
//    }];
    [BaseNetWork getdataWithString:@"member/setcollect" parameters:@{@"uid":ID} scuccessBlock:^(NSDictionary *result) {
        successBlock();
        
    } fail:^{
        
    }];

}
+(void)delAttentionWithID:(NSString *)ID success:(void(^)())successBlock{
   
    [BaseNetWork getdataWithString:@"member/delcollect" parameters:@{@"uid":ID} scuccessBlock:^(NSDictionary *result) {
        successBlock();

    } fail:^{
        
    }];
//
}

+(void)getallAttentionsuccess:(void(^)(NSArray *arr))successBlock{
    
    [BaseNetWork getdataWithString:@"member/getcollectids" parameters:nil scuccessBlock:^(NSDictionary *result) {
        NSMutableArray *arrID  = [[NSMutableArray alloc]init];;
        for (NSString *str in result) {
            [arrID addObject:str];
        }
        successBlock( arrID);
    } fail:^{
        
    }];
    
}

@end
