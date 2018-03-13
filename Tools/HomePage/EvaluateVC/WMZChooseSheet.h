//
//  WMZChooseSheet.h
//  网红评估工具
//
//  Created by More on 16/9/30.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMZChooseSheet : UIActionSheet{
}
@property (nonatomic, copy) void(^GetSelectStr)(NSString *result);
@property(nonatomic,strong)    NSArray *dataSoure;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)NSString *titleStr;
- (void)makeUI ;
@end
