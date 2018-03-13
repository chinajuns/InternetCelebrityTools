//
//  WMZUIalertVC.h
//  钱转转
//
//  Created by More on 16/11/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMZUIalertVC : NSObject

/**
 快速生成alert

 @param title 提示
 @param message 内容
 @param cancel 按钮1
 @param cancelBlock 按钮回调
 @param ok 按钮2
 @param okBlock 按钮回调
 @return alert
 */
+(UIAlertController *)CreatAlertWithTitle:(NSString *)title message:(NSString *)message CancelBtn:(NSString *)cancel cancelBlock:(void (^)())cancelBlock  OKBtn:(NSString *)ok OKBlock:(void(^)())okBlock;
+(UIAlertController *)CreatAlertWithTitle:(NSString *)title message:(NSString *)message CancelBtn:(NSString *)cancel cancelBlock:(void (^)())cancelBlock  ;
@end
