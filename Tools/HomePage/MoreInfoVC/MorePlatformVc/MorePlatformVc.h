//
//  MorePlatformVc.h
//  网红评估工具
//
//  Created by More on 16/10/31.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MorePlatformVc : UIViewController
@property (strong, nonatomic)  UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *chooseArr;
@property(nonatomic,strong)void(^choosePlatS)(NSDictionary *dic);
@property(nonatomic,strong)NSDictionary *dataDic;
@end
