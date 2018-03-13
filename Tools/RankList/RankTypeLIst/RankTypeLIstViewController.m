//
//  RankTypeLIstViewController.m
//  网红评估工具
//
//  Created by More on 16/10/27.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RankTypeLIstViewController.h"
#import "MoreHotCell.h"
#import "MoreHotNewWork.h"
#import "GetTypeListNet.h"
#import "RankLIstPerInfoTableViewController.h"
#import "AlertSheet.h"
@interface RankTypeLIstViewController ()<UITableViewDelegate,UITableViewDataSource>{

    MoreHotModel *dataModel;
    int page;
    NSMutableDictionary *par;

}
@property (weak, nonatomic) IBOutlet UITableView *listTable;

@end

@implementation RankTypeLIstViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_listTable reloadData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
   
}

-(void)viewWillDisappear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self .automaticallyAdjustsScrollViewInsets =NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
  
    [self ZJ_CustomNaviRightButtonWithImage:[UIImage imageNamed:@"图层-45"]];

    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
  
    self.title = _narStr;
    _listTable.delegate =self;
    _listTable.dataSource =self;
    page =1;

    if (_tag) {
        par=(NSMutableDictionary*) @{@"tag":_tag,@"type":_type,@"page":[NSString stringWithFormat:@"%d",page]};
    }else{
        par=(NSMutableDictionary *) @{@"type":_type,@"page":[NSString stringWithFormat:@"%d",page]};
    }
    // 下拉刷新
    _listTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page =1;

        if (_tag) {
            par=(NSMutableDictionary*) @{@"tag":_tag,@"type":_type,@"page":[NSString stringWithFormat:@"%d",page]};
        }else{
            par=(NSMutableDictionary *) @{@"type":_type,@"page":[NSString stringWithFormat:@"%d",page]};
        }
        [SVProgressHUD show];
        
        [GetTypeListNet getListWithapi:_api  Type:par success:^(MoreHotModel *model) {
            dataModel = model;
            [_listTable reloadData];
            [SVProgressHUD dismiss];
            [_listTable.mj_header endRefreshing];
        }fail:^{
            [_listTable.mj_header endRefreshing];

        }];
      
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _listTable.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    _listTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
        if (_tag) {
            par=(NSMutableDictionary*) @{@"tag":_tag,@"type":_type,@"page":[NSString stringWithFormat:@"%d",page]};
        }else{
            par=(NSMutableDictionary *) @{@"type":_type,@"page":[NSString stringWithFormat:@"%d",page]};
        }
        [SVProgressHUD show];
       [GetTypeListNet getListWithapi:_api  Type:par success:^(MoreHotModel *model) {
            [dataModel.arr addObjectsFromArray:model.arr];
            [_listTable reloadData];
            [SVProgressHUD dismiss];
            [_listTable.mj_footer endRefreshing];
        } fail:^{
            [_listTable.mj_footer endRefreshing];

        }];            // 结束刷新
    }];
    
    
    
    [SVProgressHUD show];
    
    [GetTypeListNet getListWithapi:_api  Type:par success:^(MoreHotModel *model) {
        dataModel = model;
        [_listTable reloadData];
        [SVProgressHUD dismiss];
    } fail:^{
        
    }];
    
    // Enter the refresh status immediately
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableViewDelegae
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataModel.arr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreHotCell *cell=[tableView dequeueReusableCellWithIdentifier:@"moreHot"];
    if (!cell) {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"MoreHotCell" owner:nil options:nil] firstObject];
    }
    if (dataModel) {
        cell.model = dataModel.arr[indexPath.row];
        [cell configWithModel];
        NSMutableArray *arr  = [[MYBaseInfo defaultManager] refreash];
        if ([arr containsObject:cell.model.uid]) {
            cell.isattention.selected = YES;
        }else{
            cell.isattention.selected = NO;
        }

        
    }
    cell.isattention.tag = 100+indexPath.row;
//    [cell.isattention addTarget:self action:@selector(addAtt:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    RankLIstPerInfoTableViewController *vc = [story instantiateViewControllerWithIdentifier:@"RankLIstPerInfoTableViewController"];
    //由navigationController推向我们要推向的view
      vc.uid = dataModel.arr[indexPath.row].uid;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)ZJ_CustomNaviLeftButtonClicked{
    NSArray *types = @[@"时尚",@"美食",@"搞笑",@"娱乐",@"明星",@"游戏",@"旅游",@"健康",@"宠物",@"科技",@"新人榜",@"活跃榜"];
    NSArray *typesEven = @[@"fasionBack",@"foodBack",@"wagBack",@"relaxBack",@"starBack",@"gameBack",@"toursimBack",@"heaalthBack",@"petBack",@"technologyBack",@"newBack",@"liveBack"];
    NSInteger index = [types indexOfObject:_tag];
    [MobClick event:typesEven[index]];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ZJ_CustomNaviRightButtonClicked{
    [MobClick event:@"ranRoal"];
    
    AlertSheet *typesheet = [[AlertSheet alloc] initWithFrame:self.tabBarController.view.bounds];
    [typesheet makeUIWithTitle: @"红人墙排名是根据您的年龄，城市,BMI值（体质指数）,各网络平台粉丝数等多维度数据，通过独特算法所得。"];
    [self.tabBarController.view addSubview:typesheet];
    
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
