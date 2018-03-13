//
//  CustomTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *isMustImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@end
