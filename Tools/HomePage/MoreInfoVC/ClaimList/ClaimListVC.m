//
//  ClaimListVC.m
//  网红评估工具
//
//  Created by More on 16/11/1.
//  Copyright © 2016年 More. All rights reserved.
//

#import "ClaimListVC.h"
#import "MoreHotRecomVC.h"
#import "MoreHotCell.h"
#import "RankLIstPerInfoTableViewController.h"
#import "MoreInfoViewController.h"
@interface ClaimListVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ClaimListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    self.title  =@"认领列表";
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    [_tableView registerNib:[UINib nibWithNibName:@"MoreHotCell" bundle:nil] forCellReuseIdentifier:@"HotCell"];
    // Do any additional setup after loading the view.
}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    MoreInfoViewController *vc = self.navigationController.viewControllers.lastObject;
//    [vc performSegueWithIdentifier:@"gotoResult" sender:self];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MoreHotCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"HotCell"];
    if (_dataArr) {
        cell.model = _dataArr[indexPath.row];
        [cell configWithModel];
        
    }
    cell.isattention.enabled = NO;
    [cell.isattention setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [cell.isattention setTitle:@"认领" forState:UIControlStateNormal];
            cell.backgroundColor = [UIColor clearColor];
            //粉红.png
            return cell;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    RankLIstPerInfoTableViewController *vc = [story instantiateViewControllerWithIdentifier:@"RankLIstPerInfoTableViewController"];
    //由navigationController推向我们要推向的view
    vc.uid = _dataArr[indexPath.row].uid;
    [self.navigationController pushViewController:vc animated:YES];


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
