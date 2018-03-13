//
//  ClaimListVC.h
//  网红评估工具
//
//  Created by More on 16/11/1.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreHotRecomVC.h"
#import "MoreHotNewWork.h"

@interface ClaimListVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray<HotPersonModel *> *dataArr;
@end
