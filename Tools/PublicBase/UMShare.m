//
//  UMShare.m
//  网红评估工具
//
//  Created by More on 16/10/20.
//  Copyright © 2016年 More. All rights reserved.
//

#import "UMShare.h"
#import <UMSocialCore/UMSocialCore.h>
#import "HomeNet.h"
static UMShare *DefaultManager = nil;


@implementation UMShare
+ (UMShare *)defaultManager {
    if (!DefaultManager) DefaultManager = [[self allocWithZone:NULL] init];
    return DefaultManager;
}
#pragma mark
-(void)loginWithPlatformType:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        NSString *message = nil;
        if (error) {
            NSLog(@"Auth fail with error %@", error);
            message = @"Auth fail";
        }else{
            if ([result isKindOfClass:[UMSocialAuthResponse class]]) {
                UMSocialAuthResponse *resp = result;
                // 授权信息
                NSLog(@"AuthResponse uid: %@", resp.uid);
                NSLog(@"AuthResponse accessToken: %@", resp.accessToken);
                NSLog(@"AuthResponse refreshToken: %@", resp.refreshToken);
                NSLog(@"AuthResponse expiration: %@", resp.expiration);
                
                // 第三方平台SDK源数据,具体内容视平台而定
                NSLog(@"AuthOriginalResponse: %@", resp.originalResponse);
                message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,resp.uid,resp.accessToken];
            }else{
                NSLog(@"Auth fail with unknow error");
                message = @"Auth fail";
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Auth"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                              otherButtonTitles:nil];
        [alert show];
    }];

}

-(void)cancelWithPlatformType:(UMSocialPlatformType)platformType{
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消授权"
                                                            message:@"取消授权成功"
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];

}
#pragma mark
-(void)getInfomationWithPlatformType:(UMSocialPlatformType)platformType{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}
#pragma mark 分享
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        successBlock();
        [self alertWithError:error];
    }];
}

//分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"photo1"];
    [shareObject setShareImage:@"http://dev.umeng.com/images/tab2_1.png"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        successBlock();
        [self alertWithError:error];
    }];
}

//分享图片和文字
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"photo1"];
    [shareObject setShareImage:@"http://dev.umeng.com/images/tab2_1.png"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        successBlock();
        [self alertWithError:error];
    }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)titile success:(void(^)())successBlock
{
    NSError *err;
    PersonnalModel* dataModel = [[PersonnalModel alloc]initWithDictionary: DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我在全国打败了75%的用户，赶紧来测一测你的颜值" descr:@"连明星都爱用的测试软件，要用就一定要用最专业的测试工具" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
//    NSInteger rank =  [dataModel.influence_ranking integerValue];
//    NSInteger total = [dataModel.usertotal integerValue];
//    NSString *str2 = [NSString stringWithFormat:@"%.0f%%",rank*0.1/total *100];
//    
//    NSString *title =[NSString stringWithFormat:@"我的网络影响力为%@分，击败了%@的网红，快下载红人墙测测你的得分吧！",dataModel.influence,str2];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:titile descr:@"红人墙，明星红人都在用的测试软件。更多专业、精准的网络数据，尽在红人墙！" thumImage:[UIImage imageNamed:@"603X"]];

    shareObject.webpageUrl = [NSString stringWithFormat:@"http://testhot.cdmoreyoung.com/index.php?r=share/index&uid=%@",dataModel.uid];

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        successBlock();
        [self alertWithError:error];
    }];
  }

//音乐分享
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"603X"]];
    //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        successBlock();
        [self alertWithError:error];
    }];
    
}

//视频分享
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType success:(void(^)())successBlock
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置视频网页播放地址
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        successBlock();
        [self alertWithError:error];
    }];
}



- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
        result = [NSString stringWithFormat:@"分享成功"];

    }
    else{
        if (error) {
            switch (error.code) {
                case 2009:
                    result=@"分享已取消";
                    break;
                case 2005:
                    result=@"分享内容不能为空";
                    break;
                case 2007:
                    result=@"分享内容不支持";
                    break;
                    
                default:
                    result=@"分享失败，请重试";

                    break;
            }
//            result = [NSString stringWithFormat:@"Share fail with error code: %d\n",(int)error.code];
        }
        else{
            result=@"网络异常请稍候再试";

//            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"确认", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}
@end
