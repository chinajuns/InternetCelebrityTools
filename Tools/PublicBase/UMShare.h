//
//  UMShare.h
//  网红评估工具
//
//  Created by More on 16/10/20.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface UMShare : NSObject
+ (UMShare *)defaultManager ;
-(void)loginWithPlatformType:(UMSocialPlatformType)platformType;

-(void)cancelWithPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock;
-(void)getInfomationWithPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock;
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock;
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock;
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)titile success:(void(^)())successBlock;

@end
