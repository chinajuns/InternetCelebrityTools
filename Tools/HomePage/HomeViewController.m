//
//  HomeViewController.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHasView.h"
#import "UMSocialUIManager.h"
#import "HomeNet.h"
#import "ShareView.h"
#import "LoopProgressView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMessage.h"
#import "HomeNullView.h"
#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)
#import <PopMenu.h>
@interface HomeViewController ()<shareDelegeta,CAAnimationDelegate,UNUserNotificationCenterDelegate>{
    HomeHasView  *homeView;
    HomeNullView *hNullView;
    PersonnalModel *dataModel;
    UIView *shareBack;
    ShareView *shareView;
    LoopProgressView *custom;
    

    bool hasInfo;
}
@property (weak, nonatomic) IBOutlet UIButton *infoPersentBtn;
@property (weak, nonatomic) IBOutlet UIButton *platformPersentBtn;
@property (weak, nonatomic) IBOutlet UIButton *businessPersentBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (weak, nonatomic) IBOutlet UIView *resultView;
//360
@end

@implementation HomeViewController
-(void)BottomRefUIWithUse:(BOOL)use {
    if (use) {
     
        [_infoPersentBtn setTitleColor: [UIColor colorWithHexString:@"FF8481"] forState:UIControlStateNormal];
        [_platformPersentBtn setTitleColor: [UIColor colorWithHexString:@"FF8481"] forState:UIControlStateNormal];
        [_businessPersentBtn setTitleColor: [UIColor colorWithHexString:@"FF8481"] forState:UIControlStateNormal];
        

        [_infoPersentBtn setBackgroundImage:[UIImage imageNamed:@"有色框"] forState:UIControlStateNormal];
        [_platformPersentBtn setBackgroundImage:[UIImage imageNamed:@"有色框"] forState:UIControlStateNormal];
        [_businessPersentBtn setBackgroundImage:[UIImage imageNamed:@"有色框"] forState:UIControlStateNormal];
    }else{
        [_infoPersentBtn setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        [_platformPersentBtn setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        [_businessPersentBtn setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        [_infoPersentBtn setTitle:@"——" forState:UIControlStateNormal];
        [_platformPersentBtn setTitle:@"——" forState:UIControlStateNormal];
        [_businessPersentBtn setTitle:@"——" forState:UIControlStateNormal];
        [_infoPersentBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-4灰色"] forState:UIControlStateNormal];
        [_platformPersentBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-4灰色"] forState:UIControlStateNormal];
        [_businessPersentBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-4灰色"] forState:UIControlStateNormal];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        if(!dataModel  ){
            if(((NSDictionary *)DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail")).allKeys.count <=0){
                [SVProgressHUD show];

            }
        }
        [HomeNet getInfomationSuccess:^(PersonnalModel *model) {
            NSDictionary *perDetailInfo =  [MYObjectToNsDictionary getObjectData:model];
            DEF_PERSISTENT_SET_OBJECT(perDetailInfo , @"peronInfoDetail");
            NSLog(@"Save SUccess");
            dataModel =model;
            if ([model.glamorous integerValue] ==0) {
                if (!hNullView.isUse) {
                    hNullView.isUse = YES;

                    [homeView removeFromSuperview];
                    [self.view insertSubview:hNullView aboveSubview:homeView];
                }
                [self BottomRefUIWithUse:NO];
             
                [hNullView makeUIWIthInforWithModel:model];
                [_infoPersentBtn setTitle:@"——" forState:UIControlStateNormal];

        }else{
            if (!homeView.isUse) {
                homeView.isUse = YES;
                [hNullView removeFromSuperview];
                [self.view insertSubview:homeView aboveSubview:hNullView];
            }
            [self BottomRefUIWithUse:YES];

            [homeView makeUIWIthInforWithModel:model];
            
            NSString *str2 = [NSString stringWithFormat:@" %.0f%% ",[self getPersent] *100];
            [_infoPersentBtn setTitle:str2 forState:UIControlStateNormal];
        }
            [self.view setNeedsLayout];

      
        [SVProgressHUD dismiss];
    }];
    
    
   // self.navigationController.navigationBarHidden = YES;

}
-(void)refBtnPressed{
    [SVProgressHUD show];
    [HomeNet getInfomationSuccess:^(PersonnalModel *model) {
        NSDictionary *perDetailInfo =  [MYObjectToNsDictionary getObjectData:model];
        DEF_PERSISTENT_SET_OBJECT(perDetailInfo, @"peronInfoDetail");
        NSLog(@"Save SUccess");
        dataModel =model;
        if ([model.glamorous integerValue] ==0) {
            if (!hNullView.isUse) {
                [homeView removeFromSuperview];
                hNullView.isUse = YES;
                [self.view insertSubview:hNullView aboveSubview:homeView];

            }
            [hNullView makeUIWIthInforWithModel:model];
            [self BottomRefUIWithUse:NO];
            [_infoPersentBtn setTitle:@"——" forState:UIControlStateNormal];
          
        }else{
            if (!homeView.isUse) {
                homeView.isUse = YES;
                [self.view insertSubview:homeView aboveSubview:hNullView];

            }
            [self BottomRefUIWithUse:YES];

            [homeView makeUIWIthInforWithModel:model];
            NSString *str2 = [NSString stringWithFormat:@" %.0f%% ",[self getPersent] *100];
            [_infoPersentBtn setTitle:str2 forState:UIControlStateNormal];
        }
        [self.view setNeedsLayout];

//        NSString *str2 = [NSString stringWithFormat:@" %.0f%% ",[self getPersent] *100];
//        [_infoPersentBtn setTitle:str2 forState:UIControlStateNormal];
        [SVProgressHUD dismiss];
    }];

}
-(void)notice:(NSNotification *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil  message:@"您的帐号在其它地方登陆,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) {
        
        DEF_PERSISTENT_SET_OBJECT(nil, @"peronInfoDetail");
//        DEF_PERSISTENT_SET_OBJECT(nil, @"Token");
        
        if (self.tabBarController.parentViewController) {
            [self dismissViewControllerAnimated:NO completion:^{
                //添加 字典，将label的值通过key值设置传递
                NSDictionary *dict = @{@"tong":@"zhi"}   ;//创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }];
        }else{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            UINavigationController *firstController = [story instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.tabBarController presentViewController:firstController animated:NO completion:^{
                [self.tabBarController setSelectedIndex:0];
            }];
        }
    }];
    
    
    [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}
-(void)NewMessage{
    //显示
    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self reciveNoti];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"OtherLogin" object:nil];
  
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(NewMessage) name:@"NewMessage" object:nil];

    [self ZJ_CustomNaviRightButtonWithImage:[UIImage imageNamed:@"分享"]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView *titleImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    self.navigationItem.titleView = titleImage;
    [HomeNet getallAttentionsuccess:^(NSArray *arr) {
        DEF_PERSISTENT_SET_OBJECT(arr, @"ATTENARR");
    }];
    [_infoPersentBtn sizeToFit];
    [_platformPersentBtn sizeToFit];
    [_businessPersentBtn sizeToFit];
    CGFloat height = SCREEN_HEIGHT - AdaptedHeightValue(350);
    
    
    _bottomHeight.constant  = AdaptedHeightValue(350);

    hNullView = [HomeNullView instanceTView];
    hNullView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height );

    [hNullView.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [hNullView.refBtn addTarget:self action:@selector(gotoEalua:) forControlEvents:UIControlEventTouchUpInside];
    [hNullView updateFocusIfNeeded];
    [hNullView ResetHeight:(height-64-49)/320.0];
    [self BottomRefUIWithUse:NO];

    hNullView.isUse = NO;
    homeView = [HomeHasView instanceTView];
    
    
    homeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height );
    [homeView.refBtn addTarget:self action:@selector(refBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    homeView.isUse = NO;
    [homeView updateFocusIfNeeded];
    [homeView ResetHeight:(height-64-49)/320.0];
    [self.view setNeedsLayout];



    
    NSError* err = nil;
    NSLog(@"%lu",(unsigned long)((NSDictionary *)DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail")).allKeys.count);
    if(((NSDictionary *)DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail")).allKeys.count >0){
        
        PersonnalModel *model = [[PersonnalModel alloc]initWithDictionary:DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
                if ([model.glamorous integerValue] ==0) {
                    
                    [self BottomRefUIWithUse:NO];
                    
                    hNullView.isUse =YES;
                    
                    [hNullView makeUIWIthInforWithModel:model];
                    [self.view addSubview:homeView];
                    [self.view addSubview:hNullView];
                    [_infoPersentBtn setTitle:@"——" forState:UIControlStateNormal];

                }else{
                    homeView.isUse = NO;
                    [homeView makeUIWIthInforWithModel:model];
                    [self BottomRefUIWithUse:YES];
                    [self.view addSubview:hNullView];
                    [self.view addSubview:homeView];
                    
                    [homeView makeUIWIthInforWithModel:model];
                    NSString *str2 = [NSString stringWithFormat:@" %.0f%% ",[self getPersent] *100];
                    [_infoPersentBtn setTitle:str2 forState:UIControlStateNormal];
                    
                }
        

        _infoPersentBtn.titleLabel.minimumScaleFactor  = 0.5;
        
        
     }else{
        [self.view addSubview:homeView];
        [self.view addSubview:hNullView];
    }

}
-(void)ZJ_CustomNaviRightButtonClicked{

    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"新浪微博" iconName:@"M新浪.png" index:0];

//                                               glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"朋友圈" iconName:@"M朋友圈.png" index:1];

//                                     glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"微信好友" iconName:@"M微信.png" index:2];

//                                     glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc]  initWithTitle:@"QQ好友" iconName:@"MFQQ.png" index:3];
//                                      glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    

    
    PopMenu *popMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) items:items];
    popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
        [self shareToPlaWithTag:(int)selectedItem.index];
    };
    popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase; // kPopMenuAnimationTypeSina
    popMenu.perRowItemCount = 2; // or 2
    [popMenu showMenuAtView:self.tabBarController.view];

    
}
-(void)shareToPlaWithTag:(int)tag{
    [MobClick event:@"homeShare"];

    switch (tag) {
        case 0:{
            
                [[UMShare defaultManager] shareWebPageToPlatformType:UMSocialPlatformType_Sina withTitle:@"快下载红人墙测测你的价值吧。"  success:^{
                    [self clickEmpty:nil];
                }];
            break;

            }
        case 1:{
                [[UMShare defaultManager]shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine   withTitle:@"快下载红人墙测测你的价值吧。" success:^{
                    [self clickEmpty:nil];
   
                }];
                break;

            }
        case 2:{
            [[UMShare defaultManager]shareWebPageToPlatformType:UMSocialPlatformType_WechatSession  withTitle:@"快下载红人墙测测你的价值吧。" success:^{
                [self clickEmpty:nil];

            }];
            break;
            }
            
        case 3:{
                [[UMShare defaultManager]shareWebPageToPlatformType:UMSocialPlatformType_QQ withTitle:@"快下载红人墙测测你的价值吧。"  success:^{
                    [self clickEmpty:nil];

                }];
            break;

            }
//        case 5:{
//                [[UMShare defaultManager]shareWebPageToPlatformType:UMSocialPlatformType_Sina success:^{
//                    [self clickEmpty:nil];
// 
//                }];
//                break;
//            }
        default:
                break;
        }

}
#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [shareBack removeFromSuperview];
    [shareView removeFromSuperview];
}
- (IBAction)busiBtnPressed:(id)sender {
    [MobClick event:@"homePrice"];
    if (
        !hNullView.isUse ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"到个人信息备注多增加自己的活动经历吧。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击我要估值，可提升您的排名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
- (IBAction)actiBtnPressed:(id)sender {
    [MobClick event:@"homeBusiness"];
    if (
        !hNullView.isUse ) {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"平台活跃度是由资料的完整度和你的更新频率而定，快去更新和转发，提升自己的排名吧！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击我要估值，可提升您的排名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
- (IBAction)gotoEalua:(UIButton *)sender {
    if(sender == hNullView.refBtn){
              [self performSegueWithIdentifier:@"gotoEva" sender:self];
        [MobClick event:@"homeEvaLuate"];

    }else{
        [MobClick event:@"homeInfoComeplete"];

        NSError* err = nil;
        PersonnalModel *model = [[PersonnalModel alloc]initWithDictionary:DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
        if (model) {
            if ([model.glamorous integerValue] ==0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击我要估值，可提升您的排名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return;
            }
        }
        [self performSegueWithIdentifier:@"gotoEva" sender:self];

    }
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

    self.navigationController.navigationBar.hidden = NO;
}
-(CGFloat)getPersent{
    int tem  = 4;
    int totle = 4;
    ///昵称 头像  性别  城市
    NSString *bir = [self formateDateNum:dataModel.birthday withFormateStr:@"yyyy-MM-dd"];
    if (![bir isEqualToString:@"1970-01-01"]) {
        tem++;
    }
    totle++;
    if ([dataModel.height integerValue]!=0){
        tem++;
    }
    totle++;

    if([dataModel.weight integerValue]!=0){
        tem ++;
    }
    totle++;
    ///擅长
    if (dataModel.tags.count!=0) {
        tem++;
    };
    totle++;
    if (dataModel.platform_info.count!=0) {
        tem++;
    };
    totle++;
    if (dataModel.income.count!=0) {
        tem++;
    };
    totle++;
    if (dataModel.business.count!=0) {
        tem++;
    };
    totle++;
    if (dataModel.desc.length!=0) {
        tem++;
    };
    totle++;
    if (dataModel.live_province.length!=0) {
        tem++;
    };
    totle++;
    if (dataModel.live_city.length!=0) {
        tem++;
    };
    totle++;
    if ([dataModel.sex integerValue]==0) {
        if ([dataModel.bust integerValue]!=0) {
            tem++;
        }
        totle++;
        if ([dataModel.waistline integerValue]==0) {
            tem++;
        }
        totle++;
        if ([dataModel.hipline integerValue]==0) {
            tem++;
        }
        totle++;
    }
    return tem *1.00/totle;

}
-(NSString *)formateDateNum:(NSInteger) dateNum withFormateStr:(NSString *)formatstr
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:formatstr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/chongqing"];
    [formater setTimeZone:timeZone];
    NSString *dateStr = [formater stringFromDate:date];
    
    return dateStr;
}
- (void)drawRoundView {
    if(!custom){
        custom = [[LoopProgressView alloc]initWithFrame:_infoPersentBtn.frame];
        
    }else{
        [custom removeFromSuperview];
        custom=nil;
        custom = [[LoopProgressView alloc]initWithFrame:_infoPersentBtn.frame];
    }
    CGFloat per = [[NSString stringWithFormat:@"%.2f",[self getPersent]] doubleValue];
    if(dataModel){
        custom.progress = per;

    }else{
        custom.progress = 0;

    }

    [self.view insertSubview:custom belowSubview:_infoPersentBtn];
}
-(void)viewDidLayoutSubviews{
//    [self drawRoundView];

}
-(void)reciveNoti{
    
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

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
