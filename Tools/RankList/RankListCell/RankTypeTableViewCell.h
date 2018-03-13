//
//  RankTypeTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/9/29.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TypeBtnPressDelegate
-(void)typeBtnPressed:(UIButton *)button;//1.1定义协议与方法
@end

@interface RankTypeTableViewCell : UITableViewCell
@property (retain,nonatomic) id <TypeBtnPressDelegate> typeDelegate;
@end
