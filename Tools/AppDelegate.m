//
//  AppDelegate.m
//  网红评估工具
//
//  Created by More on 16/9/27.
//  Copyright © 2016年 More. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
#import "IQKeyboardManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import "LoginViewController.h"
#import "CustomTabbarViewController.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>{
    UIImageView *imageView;
}

@end

@implementation AppDelegate
- (void)notifi:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    
    //获取网络状态
    NSInteger status = [[dic objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"] integerValue];
    
    if(status == AFNetworkReachabilityStatusNotReachable) {
        DEF_PERSISTENT_SET_OBJECT(@"0", @"NET");
        //无网络连接
        NSLog(@"0");
//        self.netWorkingStatus = @"0";
        
    }else if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
        NSLog(@"1");
        DEF_PERSISTENT_SET_OBJECT(@"1", @"NET");

        //蜂窝网络或者Wi-Fi连接
//        self.netWorkingStatus = @"1";
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    DEF_PERSISTENT_SET_OBJECT(@"1", @"NET");

    
    UMConfigInstance.appKey = @"57ea220c67e58e04aa00261f";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [self AFNetworkStatus];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
//
//    if  (!DEF_PERSISTENT_GET_OBJECT(@"Message")){
//        NSMutableArray *messages = [[NSMutableArray alloc]init];
//        NSDate *currentDate = [NSDate date];//获取当前时间，日期
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
//        NSString *dateString = [dateFormatter stringFromDate:currentDate];
//        [messages addObject:@{dateString:@"欢迎加入魔漾"}];
//        
//       DEF_PERSISTENT_SET_OBJECT(messages, @"Message");
//        
//    }

    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"FF8481"]} forState:UIControlStateSelected];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:@"57f88547e0f55addb400166a" launchOptions:launchOptions];
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    [UMessage registerForRemoteNotifications];
    
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    [UMessage setAutoAlert:NO];
    [UMessage setBadgeClear:NO];
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    
    //打开调试日志
//    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"BPCWayxQOhRbGVfx"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105650123"  appSecret:@"BPCWayxQOhRbGVfx" redirectURL:@"http://mobile.umeng.com/social"];

    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"77702242"  appSecret:@"3219742271817516649d92652de4b18e" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx72afcefc8690e809"  appSecret:@"455c5829c1c476d4c63572d64692156f" redirectURL:@"http://mobile.umeng.com/social"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NSLog(@"peronInfoDetail ===  %@",DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail"));
    if(DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") ){
        CustomTabbarViewController *firstController = [story instantiateViewControllerWithIdentifier:@"CustomTabbarViewController"];
        self.window.rootViewController = firstController;
        
    }else{
        UINavigationController *firstController = [story instantiateViewControllerWithIdentifier:@"LoginViewController"];
        self.window.rootViewController = firstController;
    }
    
 

    [self.window makeKeyAndVisible];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *dev = [deviceToken description] ;
    dev = [ dev stringByReplacingOccurrencesOfString: @"<" withString: @""];
    dev = [ dev stringByReplacingOccurrencesOfString: @">" withString: @""];
    dev = [ dev stringByReplacingOccurrencesOfString: @" " withString: @""];
    DEF_PERSISTENT_SET_OBJECT(dev, @"Token");
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"dev == %@",DEF_PERSISTENT_GET_OBJECT(@"Token"));
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
    
    
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"NewMessage" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
  

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"招聘H5.png"];
    [self.window addSubview:imageView];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [imageView removeFromSuperview];
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        if (DEF_PERSISTENT_GET_OBJECT(@"Token")) {
            [BaseNetWork loginTotal];

        }
    });
 
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
////iOS10新增：处理前台收到通知的代理方法
//-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //应用处于前台时的远程推送接受
//        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
//        
//    }else{
//        //应用处于前台时的本地推送接受
//    }
//
//}
//
////iOS10新增：处理后台点击通知的代理方法
//-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //应用处于后台时的远程推送接受
//        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
//        
//    }else{
//        //应用处于后台时的本地推送接受
//    }
//    
//
-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}
-(BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}
-(void)AFNetworkStatus{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"未知网络状态");
                break;
            }
                
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"蜂窝数据网");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                break;
            }
                
            default:
                break;
        }
        
        
    }] ;
    
    [manager startMonitoring];

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
