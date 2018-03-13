//
//  BaseNetWork.m
//  网红评估工具
//
//  Created by More on 16/10/21.
//  Copyright © 2016年 More. All rights reserved.
//

#import "BaseNetWork.h"
@interface BaseNetWork (){
}

@end
@implementation BaseNetWork
+(void)loginTotal{
        [BaseNetWork postdataWithString:@"member/loginnum" parameters:nil scuccessBlock:^(NSDictionary *result) {
            
        }];
}
+ (void)getdataWithString:(NSString *)urlString parameters:(NSDictionary *)parameters   scuccessBlock:(void(^)(NSDictionary* result))successBlock fail:(void(^)())fiaBlock{
    
    
    if ([DEF_PERSISTENT_GET_OBJECT(@"NET") integerValue]==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到网络，请检查网络连接" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        [SVProgressHUD dismiss];

        return ;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@&deviceid=%@&token=%@",BaseUrl,urlString,DEF_PERSISTENT_GET_OBJECT(@"Token"),  DEF_PERSISTENT_GET_OBJECT(@"LoginToken") ] );
    
    [manager GET:[NSString stringWithFormat:@"%@%@&deviceid=%@&token=%@",BaseUrl,urlString,DEF_PERSISTENT_GET_OBJECT(@"Token"),  DEF_PERSISTENT_GET_OBJECT(@"LoginToken") ] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if ([responseObject[@"status"] integerValue]==0 ) {
                 [SVProgressHUD showWithStatus:responseObject[@"info"]];
                 [SVProgressHUD dismissWithDelay:1];
                 return ;
             }
             if ([responseObject[@"status"] integerValue]==10012 ) {
                 //创建一个消息对象
                 NSNotification * notice = [NSNotification notificationWithName:@"OtherLogin" object:nil userInfo:nil];
                 //发送消息
                 [[NSNotificationCenter defaultCenter]postNotification:notice];
             }
             NSLog(@"%@",responseObject[@"data"]);
             
             if ([responseObject[@"status"] integerValue]==1 ) {

             successBlock(responseObject[@"data"]);
             }
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             NSLog(@"%@",error);  //这里打印错误信息
             [SVProgressHUD showErrorWithStatus:@"网络错误，请稍后再试"];
             [SVProgressHUD dismissWithDelay:1];
             fiaBlock();
         }];
    

    

    
}
+ (void)postdataWithString:(NSString *)urlString parameters:(NSDictionary*)parameters   scuccessBlock:(void(^)(NSDictionary* result))successBlock{

    
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
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue]==0 ) {
            if ([urlString isEqualToString:@"member/loginnum"]) {
                return ;

            }
            [SVProgressHUD showWithStatus: responseObject[@"info"]];
             [SVProgressHUD dismissWithDelay:1];

            return ;
        }
        if ([responseObject[@"status"] integerValue]==10012 ) {
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"OtherLogin" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
        NSLog(@"%@",responseObject[@"data"]);
        if ([responseObject[@"status"] integerValue]==1 ) {

        successBlock(responseObject[@"data"]);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);  //这里打印错误信息
        [SVProgressHUD showErrorWithStatus:@"网络错误，请稍后再试"];
        [SVProgressHUD dismissWithDelay:1];
        
    }];
}
- (void)downLoad{
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@""];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
        
    }];
    
    //开始启动任务
    [task resume];
    
}
//第一种方法是通过工程中的文件进行上传
+(void)upLoadFileWithImage:(UIImage *)image preGress:(void(^)(CGFloat progress))preGress  success:(void(^)(NSString* result))successBlock{
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@&deviceid=%@&token=%@",BaseUrl,@"user/upload-file",DEF_PERSISTENT_GET_OBJECT(@"Token"),  DEF_PERSISTENT_GET_OBJECT(@"LoginToken") ];
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *data = UIImagePNGRepresentation(image);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"file" fileName:@"head.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        preGress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        if ([responseObject[@"status"] integerValue]==0 ) {
        //            [SVProgressHUD showWithStatus:@"保存成功"];
        //             [SVProgressHUD dismissWithDelay:1];
        //            return ;
        //        }
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        successBlock(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
    
}


//第一种方法是通过工程中的文件进行上传
+(void)upLoadWithImage:(UIImage *)image preGress:(void(^)(CGFloat progress))preGress  success:(void(^)(NSDictionary* result))successBlock{
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@&deviceid=%@&token=%@",BaseUrl,@"member/uploadpic",DEF_PERSISTENT_GET_OBJECT(@"Token"),  DEF_PERSISTENT_GET_OBJECT(@"LoginToken") ];
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *data = UIImagePNGRepresentation(image);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"file" fileName:@"head.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        preGress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject[@"status"] integerValue]==0 ) {
//            [SVProgressHUD showWithStatus:@"保存成功"];
//             [SVProgressHUD dismissWithDelay:1];
//            return ;
//        }
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        successBlock(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
    
}

//第二种是通过URL来获取路径，进入沙盒或者系统相册等等
- (void)upLoda2{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

@end
