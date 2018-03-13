//
//  MoreTypeChooseVC.h
//  网红评估工具
//
//  Created by More on 16/10/31.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreTypeChooseVC : UIViewController
@property(nonatomic,strong)NSMutableArray *chooseArr;
@property(nonatomic,strong)void (^ getBeGoodArr)(NSArray *arr);
@end
