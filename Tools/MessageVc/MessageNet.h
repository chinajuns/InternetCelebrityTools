//
//  MessageNet.h
//  网红评估工具
//
//  Created by More on 16/11/1.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MessageModel : JSONModel
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *content;
@end
@interface MessageNet : NSObject
+(void)getallMessagePar:(NSDictionary *)par success:(void(^)(NSArray<MessageModel *> *arr))successBlock;
@end
