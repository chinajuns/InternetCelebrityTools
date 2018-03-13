//
//  VuthorizationOBJ.m
//  钱转转员工版
//
//  Created by More on 16/11/24.
//  Copyright © 2016年 More. All rights reserved.
//

#import "AuthorizationOBJ.h"

@implementation AuthorizationOBJ
+(void)CameraAuthorizationWithSuccessBlock:(void(^)())successBlock failBlcok:(void(^)())failBlock{
    
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusNotDetermined ){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                NSLog(@"授权成功");
                
                successBlock();
            }else{
                NSLog(@"不授权");
                failBlock();

            }
        }];
    }else if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
              authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        failBlock();
        
    }
    else{
        
        successBlock();
        
    }
}
+(void)AlbumAuthorizationWithSuccessBlock:(void(^)())successBlock failBlcok:(void(^)())failBlock{
    //相册权限
    PHAuthorizationStatus author =[PHPhotoLibrary authorizationStatus];
    
    //相册权限
    if(author == AVAuthorizationStatusNotDetermined ){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            typedef NS_ENUM(NSInteger, PHAuthorizationStatus) {
//                PHAuthorizationStatusNotDetermined = 0, // 未询问用户是否授权
//                PHAuthorizationStatusRestricted, // 未授权，例如家长控制
//                PHAuthorizationStatusDenied, // 未授权，用户拒绝造成的
//                PHAuthorizationStatusAuthorized// 已授权}
            
                          switch (status) {
                case PHAuthorizationStatusAuthorized:
                                  successBlock();
                    NSLog(@"PHAuthorizationStatusAuthorized");
                    break;
                    
                                  
                case PHAuthorizationStatusDenied:
                                  failBlock();
                    NSLog(@"PHAuthorizationStatusDenied");
                    break;
                case PHAuthorizationStatusNotDetermined:
                    NSLog(@"PHAuthorizationStatusNotDetermined");
                    break;
                case PHAuthorizationStatusRestricted:
                                  failBlock();
                    NSLog(@"PHAuthorizationStatusRestricted");
                    break;
            }
        }];

    }else if(author == PHAuthorizationStatusRestricted || author == PHAuthorizationStatusDenied ){
        failBlock();
    }else{
        successBlock();
    }
    

}
+(void)LocationAuthorizationWithSuccessBlock:(void(^)())successBlock failBlcok:(void(^)())failBlock{
   
}


@end
