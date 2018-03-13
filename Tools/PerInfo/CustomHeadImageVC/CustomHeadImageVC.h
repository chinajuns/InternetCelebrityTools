//
//  CustomHeadImageVC.h
//  网红评估工具
//
//  Created by More on 16/11/15.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeadImageVC : UIViewController
@property (nonatomic, copy) void(^ChooseImage)(UIImage  *img);

@end
