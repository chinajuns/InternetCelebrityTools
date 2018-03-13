//
//  ResultTopTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/10/12.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *backTolast;
@property (weak, nonatomic) IBOutlet UILabel *persentLable;
@property (weak, nonatomic) IBOutlet UILabel *rankLable;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end
