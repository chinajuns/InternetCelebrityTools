//
//  SexTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *womenBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property(nonatomic,strong)NSString *sexStr;
@end
