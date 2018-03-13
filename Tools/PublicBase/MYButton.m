//
//  MYButton.m
//  网红评估工具
//
//  Created by More on 16/9/29.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MYButton.h"

@implementation MYButton
// MyButton继承的是UIButton
// 按钮默认的是图片在左边，而文字在图片的右边
// 设置下面的这两个方法，就可以使按钮的图片在上面，文字在图片的下面
// 注意：这两个方法是系统自动调用的，我们不需要调用此方法
// 注意：下面的数字的设置可以根据需求来设置！！！
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.frame.size.height/3*2,self.frame.size.width, self.frame.size.height/3*1);
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.frame.size.width/3/2, 0,self.frame.size.width/3*2, self.frame.size.height/3*2);
}

@end
