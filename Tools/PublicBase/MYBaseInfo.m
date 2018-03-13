//
//  MYBaseInfo.m
//  网红评估工具
//
//  Created by More on 16/10/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MYBaseInfo.h"
static MYBaseInfo *baseInfo = nil;

@implementation MYBaseInfo
+ (MYBaseInfo *)defaultManager {
    if (!baseInfo){
        baseInfo = [[self allocWithZone:NULL] init];
        baseInfo.attenArr  = [[NSMutableArray alloc]init];
    }
    return baseInfo;
}
-(NSMutableArray *)refreash{
    [baseInfo.attenArr removeAllObjects ];
    [baseInfo.attenArr addObjectsFromArray:DEF_PERSISTENT_GET_OBJECT(@"ATTENARR")];
    return baseInfo.attenArr;
}
-(void)addAttenWIthUid:(NSString *)uid{
    [baseInfo.attenArr addObject:uid];
    DEF_PERSISTENT_SET_OBJECT(baseInfo.attenArr, @"ATTENARR");

}
-(void)delAttenWIthUid:(NSString *)uid{
    [baseInfo.attenArr removeObject:uid];
    DEF_PERSISTENT_SET_OBJECT(baseInfo.attenArr, @"ATTENARR");

}
@end
