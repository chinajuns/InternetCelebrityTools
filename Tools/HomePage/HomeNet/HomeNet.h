//
//  HomeNet.h
//  网红评估工具
//
//  Created by More on 16/10/26.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PersonnalModel : JSONModel
@property(nonatomic,assign)NSInteger birthday;
///接受的商业类型
@property(nonatomic,strong)NSArray *business;
///1 普通用户 2 商户
//@property(nonatomic,strong)NSString *business_type;
///胸围
@property(nonatomic,strong)NSString *bust;
///商业值
@property(nonatomic,strong)NSString *commercial;
@property(nonatomic,strong)NSString *old_commercial;
@property(nonatomic,strong)NSString *content;


//备注
@property(nonatomic,strong)NSString *desc;
//我的粉丝个人资料界面
@property(nonatomic,strong)NSArray *fans;
@property(nonatomic,strong)NSString *fanstotal;
@property(nonatomic,strong)NSString *followtotal;
///魅力值
@property(nonatomic,strong)NSString *glamorous;
@property(nonatomic,strong)NSString *old_glamorous;

///我的头像
@property(nonatomic,strong)NSString *head;
///身高
@property(nonatomic,strong)NSString *height;
///臀围
@property(nonatomic,strong)NSString *hipline;
///收入来源
@property(nonatomic,strong)NSArray *income;
///影响力
@property(nonatomic,strong)NSString *influence;
@property(nonatomic,strong)NSString *old_influence;

//／影响力排名
@property(nonatomic,strong)NSString *influence_ranking;
@property(nonatomic,strong)NSString *old_influence_ranking;


///是否认证 0 未认证
@property(nonatomic,strong)NSString *is_authentication;
///城市
@property(nonatomic,strong)NSString *live_city;
///省份
@property(nonatomic,strong)NSString *live_province;
//昵称
@property(nonatomic,strong)NSString *nickname;
///资料图片
@property(nonatomic,strong)NSArray *picture;
//性别
@property(nonatomic,strong)NSString *sex;
///擅长领域
@property(nonatomic,strong)NSArray *tags;
@property(nonatomic,strong)NSString *uid;
///数据更新时间
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,strong)NSString *user_type;
@property(nonatomic,strong)NSString *usertotal;
//估值
@property(nonatomic,strong)NSString *valuations;

//腰围
@property(nonatomic,strong)NSString *waistline;
///体重
@property(nonatomic,strong)NSString *weight;
///第三方平台
@property(nonatomic,strong)NSDictionary *platform_info;



@end

@interface HomeNet : NSObject
+(void)getInfomationSuccess:(void(^)(PersonnalModel *model))succexxblock;
+(void)addAttentionWithID:(NSString *)ID success:(void(^)())successBlock;
+(void)delAttentionWithID:(NSString *)ID success:(void(^)())successBlock;
+(void)getallAttentionsuccess:(void(^)(NSArray *arr))successBlock;
@end
