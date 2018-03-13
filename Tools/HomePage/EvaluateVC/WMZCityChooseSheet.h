//
//  WMZCityChooseSheet.h
//  网红评估工具
//
//  Created by More on 16/9/30.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMZCityChooseSheet : UIActionSheet
@property (nonatomic, copy) void(^GetSelectCity)(NSString *chooseCity);

@end
