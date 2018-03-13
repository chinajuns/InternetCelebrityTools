//
//  ClaimActionSHeet.h
//  网红评估工具
//
//  Created by More on 16/10/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClaimActionSHeet : UIActionSheet
@property (nonatomic, copy) void(^GetSelectDate)(NSDictionary *dateStr);
@property (nonatomic, strong) NSString * selectDate;
@property(nonatomic,strong)NSString *uid;
@end
