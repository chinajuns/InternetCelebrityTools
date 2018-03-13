//
//  UIView+CurrentController.m
//  钱转转
//
//  Created by More on 16/11/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import "UIView+CurrentController.h"

@implementation UIView (CurrentController)
/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end
