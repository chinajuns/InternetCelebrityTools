//
//  SizeTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/9/30.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SizeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *moreView;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (assign, nonatomic)  BOOL isShow;
@property (weak, nonatomic) IBOutlet UIButton *braSizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *waistSizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *hipsSizeBtn;
@end
