//
//  PersonalHeadTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/10/13.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headImage;
@property (weak, nonatomic) IBOutlet UIButton *addAttentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionMeBtn;
@property (weak, nonatomic) IBOutlet UILabel *attentionNumber;
@property (weak, nonatomic) IBOutlet UILabel *fansNumber;
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *nickName;

@end
