//
//  UITabBar+badge.h
//  网红评估工具
//
//  Created by More on 16/12/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
