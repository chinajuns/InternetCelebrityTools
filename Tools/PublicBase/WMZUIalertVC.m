//
//  WMZUIalertVC.m
//  钱转转
//
//  Created by More on 16/11/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import "WMZUIalertVC.h"

@implementation WMZUIalertVC
+(UIAlertController *)CreatAlertWithTitle:(NSString *)title message:(NSString *)message CancelBtn:(NSString *)cancel cancelBlock:(void (^)())cancelBlock  OKBtn:(NSString *)ok OKBlock:(void(^)())okBlock{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        cancelBlock();
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        okBlock();
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    return alertController;
}
+(UIAlertController *)CreatAlertWithTitle:(NSString *)title message:(NSString *)message CancelBtn:(NSString *)cancel cancelBlock:(void (^)())cancelBlock  {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        cancelBlock();
    }];
    
    
    // Add the actions.
    [alertController addAction:cancelAction];
    return alertController;
}
@end
