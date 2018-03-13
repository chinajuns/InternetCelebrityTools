//
//  OtherIDTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/10/8.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdPLNameAndID.h"

@interface OtherIDTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property(nonatomic,strong)ThirdPLNameAndID *firstPl;
@property(nonatomic,strong)ThirdPLNameAndID *sconedPl;
@property(nonatomic,strong)ThirdPLNameAndID *thirdPl;
@property(nonatomic,strong)NSDictionary *nameAndId;

-(void)refreaUIWithPlsArr:(NSArray *)arr;
-(NSDictionary *)getInfo;
-(NSDictionary *)getHZInfo;
@end
