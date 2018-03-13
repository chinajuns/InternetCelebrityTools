//
//  RankWeekTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/9/29.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankWeekTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mnewHotImage;
@property (weak, nonatomic) IBOutlet UIImageView *actHotImage;
@property (weak, nonatomic) IBOutlet UIButton *hotLIstBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotNewLIstBtn;

@end
