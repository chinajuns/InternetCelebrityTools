//
//  EvaluateNet.m
//  网红评估工具
//
//  Created by More on 16/10/26.
//  Copyright © 2016年 More. All rights reserved.
//

#import "EvaluateNet.h"

@implementation EvaluateNet
+(void)submitPerinfo:(NSDictionary *)par  Success:(void(^)(NSArray <HotPersonModel *> *date))successBlock{
    
    [EvaluateNet  postWithString:@"member/setotherprofile" parameters:par scuccessBlock:^(NSDictionary *result) {
//        NSMutableArray <HotPersonModel *>*arr = [[NSMutableArray alloc]init];
//        NSError* err = nil;
//
//        for (NSDictionary *dic in result) {
//            HotPersonModel *PersonMode = [[HotPersonModel alloc]initWithDictionary:dic error:&err];
//            [arr addObject:PersonMode];
//        }
        successBlock(nil);
    }];
}
+(void)postWithString:(NSString *)urlString parameters:(NSDictionary*)parameters   scuccessBlock:(void(^)(NSDictionary* result))successBlock{
    
    
    if ([DEF_PERSISTENT_GET_OBJECT(@"NET") integerValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到网络，请检查网络连接" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [SVProgressHUD dismiss];
        return ;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [NSString stringWithFormat:@"%@%@",BaseUrl,urlString];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@&deviceid=%@&token=%@",BaseUrl,urlString,DEF_PERSISTENT_GET_OBJECT(@"Token"),  DEF_PERSISTENT_GET_OBJECT(@"LoginToken") ] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //        NSLog(@"%@",responseObject);
//        if ([responseObject[@"status"] integerValue]==0 ) {
//            [SVProgressHUD showWithStatus: responseObject[@"info"]];
//            [SVProgressHUD dismissWithDelay:1];
//            
//            return ;
//        }
//        NSLog(@"%@",responseObject[@"data"]);
//        
        successBlock(responseObject[@"data"]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);  //这里打印错误信息
        [SVProgressHUD showErrorWithStatus:@"网络错误，请稍后再试"];
        [SVProgressHUD dismissWithDelay:1];
        
    }];
}
@end
