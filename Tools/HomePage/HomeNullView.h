//
//  HomeNullView.h
//  网红评估工具
//
//  Created by More on 16/11/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNet.h"
@interface HomeNullView : UIView
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *refBtn;
@property (weak, nonatomic) IBOutlet UILabel *lastRefTime;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top6;
@property(nonatomic,assign)bool isUse;
-(void)ResetHeight:(CGFloat)height;

-(void)makeUIWIthInforWithModel:(PersonnalModel *)model;
+(HomeNullView *)instanceTView;
@end
