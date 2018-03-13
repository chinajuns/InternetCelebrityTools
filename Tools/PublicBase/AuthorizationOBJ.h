//
//  VuthorizationOBJ.h
//  钱转转员工版
//
//  Created by More on 16/11/24.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorizationOBJ : NSObject
+(void)CameraAuthorizationWithSuccessBlock:(void(^)())successBlock failBlcok:(void(^)())failBlock;
+(void)AlbumAuthorizationWithSuccessBlock:(void(^)())successBlock failBlcok:(void(^)())failBlock;
+(void)LocationAuthorizationWithSuccessBlock:(void(^)())successBlock failBlcok:(void(^)())failBlock;
@end
