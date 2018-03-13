//
//  AlertSheet.h
//  网红评估工具
//
//  Created by More on 16/11/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertSheet : UIActionSheet
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *lable;
- (void)makeUIWithTitle:(NSString *)titile ;
@end
