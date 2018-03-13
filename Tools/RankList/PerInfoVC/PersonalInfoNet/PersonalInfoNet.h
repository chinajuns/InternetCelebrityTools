//
//  PersonalInfoNet.h
//  网红评估工具
//
//  Created by More on 16/10/26.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeNet.h"
@interface PersonalInforDetailModel : PersonnalModel
@property(nonatomic,strong)NSDictionary *data;

@end


@interface PersonalInfoNet : NSObject
+(void)getMoreInforMationWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock;

+(void)submitMistakeWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock;

+(void)setclaimWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock;

+(void)haveCoorWithPar:(NSDictionary *)parmeter success:(void(^)())successBlock;

+(void)getUserInfoDetailWithUid:(NSString *)uid Success:(void(^)(PersonalInforDetailModel *model))succexxblock fainBlock:(void(^)())failBlock;
@end
