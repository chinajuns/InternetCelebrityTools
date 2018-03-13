//
//  CustomTabbarViewController.m
//  网红评估工具
//
//  Created by More on 16/10/11.
//  Copyright © 2016年 More. All rights reserved.
//

#import "CustomTabbarViewController.h"

@interface CustomTabbarViewController ()

@end

@implementation CustomTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
    UIImageView *back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部色块"]];
    back.frame = CGRectMake(0, 0, SCREEN_WIDTH, back.frame.size.height);
    UIImageView  *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部色块"]];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, view.frame.size.height);
    [back addSubview:view];
    [[UITabBar appearance]insertSubview:back atIndex:0];
    [UITabBar appearance].translucent = NO;
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
