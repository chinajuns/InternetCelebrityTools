//
//  RankMoreInfoTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/10/14.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNet.h"
@interface RankMoreInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *addAttention;
@property (weak, nonatomic) IBOutlet UIButton *moreInfoBtn;
@property (weak, nonatomic) IBOutlet UIView *pinkView;
@property (weak, nonatomic) IBOutlet UIView *purpleView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIButton *clikMoreInforBtn;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UIButton *sexAndAgeBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property (weak, nonatomic) IBOutlet UILabel *ageLable;
@property (weak, nonatomic) IBOutlet UILabel *heightLable;
@property (weak, nonatomic) IBOutlet UILabel *weightLable;
@property (weak, nonatomic) IBOutlet UILabel *shapeLable;
@property (weak, nonatomic) IBOutlet UILabel *beGoodAtLable;
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *rankNumberLable;
@property (weak, nonatomic) IBOutlet UIButton *rankChangeLable;
@property (weak, nonatomic) IBOutlet UILabel *refreaTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *accpetTypeLable;
@property (weak, nonatomic) IBOutlet UILabel *glamorousLable;
@property (weak, nonatomic) IBOutlet UILabel *influLable;
@property (weak, nonatomic) IBOutlet UILabel *commercial;

@property (strong, nonatomic) PersonnalModel *datamodel;
-(void)configWithModel:(PersonnalModel *)model;
@end
