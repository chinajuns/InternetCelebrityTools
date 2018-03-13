//
//  HomeHasView.h
//  网红评估工具
//
//  Created by More on 16/9/29.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNet.h"

@interface HomeHasView : UIView
@property (weak, nonatomic) IBOutlet UIButton *refBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *confBtn;


@property (weak, nonatomic) IBOutlet UILabel *totalRankNumberLable;
@property (weak, nonatomic) IBOutlet UIButton *totalDIreCtionImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalChangeNumber;


@property (weak, nonatomic) IBOutlet UILabel *impLable;
@property (weak, nonatomic) IBOutlet UIButton *imChangeBtn;

@property (weak, nonatomic) IBOutlet UILabel *influeceLable;
@property (weak, nonatomic) IBOutlet UIButton *inflauceBtn;

@property (weak, nonatomic) IBOutlet UILabel *busiLable;
@property (weak, nonatomic) IBOutlet UIButton *busiBtn;

@property (weak, nonatomic) IBOutlet UILabel *currLable;

//@property (weak, nonatomic) IBOutlet UILabel *alertLableOne;
//@property (weak, nonatomic) IBOutlet UILabel *alertLableTwo;
//@property (weak, nonatomic) IBOutlet UILabel *alertLableThree;

@property (weak, nonatomic) IBOutlet UILabel *lastRefTime;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbale;

@property(nonatomic,assign)bool isUse;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width3;
@property(assign,nonatomic)BOOL isfinsh;
-(void)ResetHeight:(CGFloat)height;;
+(HomeHasView *)instanceTView;
-(void)makeUIWIthInforWithModel:(PersonnalModel *)model;
@end
