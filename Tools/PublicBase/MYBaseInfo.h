//
//  MYBaseInfo.h
//  网红评估工具
//
//  Created by More on 16/10/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYBaseInfo : NSObject
@property(nonatomic,strong)NSMutableArray *attenArr;



+ (MYBaseInfo *)defaultManager;
-(NSMutableArray *)refreash;
-(void)delAttenWIthUid:(NSString *)uid;
-(void)addAttenWIthUid:(NSString *)uid;
@end
