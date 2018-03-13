//
//  RankLIstPerInfoTableViewController.h
//  网红评估工具
//
//  Created by More on 16/10/8.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNet.h"

@interface RankLIstPerInfoTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *perTab;
@property(nonatomic,strong)NSString *uid;
@end
