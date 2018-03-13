//
//  CustomItem.m
//  网红评估工具
//
//  Created by More on 16/10/12.
//  Copyright © 2016年 More. All rights reserved.
//

#import "CustomItem.h"

@implementation CustomItem
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self  = [super initWithCoder:aDecoder]) {
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}
@end
