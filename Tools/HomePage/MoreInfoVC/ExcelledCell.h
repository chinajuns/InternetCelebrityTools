//
//  ExcelledCell.h
//  网红评估工具
//
//  Created by More on 16/9/30.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcelledCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLable;
@property (weak, nonatomic) IBOutlet UIButton *questionBtn;
@property(nonatomic,strong) NSMutableArray *seleArr;
@end
