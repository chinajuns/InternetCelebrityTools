//
//  UILabel+LabelHeightAndWidth.h
//  钱转转
//
//  Created by More on 16/11/2.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeightAndWidth)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
