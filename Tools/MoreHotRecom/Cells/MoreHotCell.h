//
//  MoreHotCell.h
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreHotNewWork.h"
@interface MoreHotCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImge;
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UILabel *NickName;
@property (weak, nonatomic) IBOutlet UILabel *influNumebr;
@property (weak, nonatomic) IBOutlet UILabel *beGoodLable;
@property (weak, nonatomic) IBOutlet UIButton *isattention;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;

@property(nonatomic,strong)HotPersonModel *model;
-(void)configWithModel;
@end
