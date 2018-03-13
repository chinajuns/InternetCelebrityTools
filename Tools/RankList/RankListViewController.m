//
//  RankListViewController.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RankListViewController.h"
#import "RankTypeTableViewCell.h"
#import "RankWeekTableViewCell.h"
#import "RankGuessTableViewCell.h"
#import "MoreHotCell.h"
#import "MoreHotRecomVC.h"
#import "MoreHotCell.h"
#import "MoreHotNewWork.h"
#import "RankLIstPerInfoTableViewController.h"
#import "RankTypeLIstViewController.h"
#import "AlertSheet.h"
@interface RankListViewController ()<UITableViewDelegate,UITableViewDataSource,TypeBtnPressDelegate>{
    UIImageView *navBarHairlineImageView;;
    NSString *typeStr;
    MoreHotModel *dataModel;
    
    int currChoose;

}

@property (weak, nonatomic) IBOutlet UITableView *listTabview;
@end

@implementation RankListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_listTabview reloadData];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
}
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (DEF_PERSISTENT_GET_OBJECT(@"RankList")) {
        MoreHotModel *model  = [[MoreHotModel alloc]init];
        model.arr = [[NSMutableArray alloc]  init];
        NSError* err = nil;
        NSDictionary *ranke = DEF_PERSISTENT_GET_OBJECT(@"RankList");
        for (NSDictionary *dic in ranke[@"arr"]) {
            HotPersonModel *PersonMode = [[HotPersonModel alloc]initWithDictionary:dic error:&err];
            [model.arr addObject:PersonMode];
        }
        dataModel = model;
        [_listTabview reloadData];
    }
    [MoreHotNewWork getListWithType:@"2" success:^(MoreHotModel *model) {
        NSDictionary *RankList =  [MYObjectToNsDictionary getObjectData:model];
        
        DEF_PERSISTENT_SET_OBJECT(RankList, @"RankList");
        dataModel = model;
        [_listTabview reloadData];
        [SVProgressHUD  dismiss];
    }];
    
    currChoose = 0;
    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.title = @"排行榜";
    [self ZJ_CustomNaviRightButtonWithImage:[UIImage imageNamed:@"图层-45"]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    _listTabview.delegate = self;
    _listTabview.dataSource =self;
    [_listTabview registerNib:[UINib nibWithNibName:@"RankTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"TypeCell"];
     [_listTabview registerNib:[UINib nibWithNibName:@"RankWeekTableViewCell" bundle:nil] forCellReuseIdentifier:@"WeekCell"];
     [_listTabview registerNib:[UINib nibWithNibName:@"RankGuessTableViewCell" bundle:nil] forCellReuseIdentifier:@"GuessCell"];
     [_listTabview registerNib:[UINib nibWithNibName:@"MoreHotCell" bundle:nil] forCellReuseIdentifier:@"HotCell"];
    _listTabview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [MoreHotNewWork getListWithType:@"2" success:^(MoreHotModel *model) {
            NSDictionary *RankList =  [MYObjectToNsDictionary getObjectData:model];
            
            DEF_PERSISTENT_SET_OBJECT(RankList, @"RankList");
            dataModel = model;
            [_listTabview reloadData];
            [SVProgressHUD  dismiss];
        }];
        [_listTabview.mj_header endRefreshing];
        
    }];    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataModel) {
        return 3+dataModel.arr.count;
    }else{
        return 3;
    }
//    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            RankTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCell"];
            cell.typeDelegate = self;
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
            break;
        case 1:{
            RankWeekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeekCell"];
            cell.hotNewLIstBtn.tag = 101;
            cell.hotLIstBtn.tag= 102;
            [cell.hotNewLIstBtn addTarget:self action:@selector(typeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [ cell.hotLIstBtn addTarget:self action:@selector(typeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell.backgroundColor = [UIColor clearColor];

            return cell;
        }
            break;
        case 2:{
            RankGuessTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"GuessCell"];
            cell.backgroundColor = [UIColor clearColor];
            [cell.changeNow addTarget:self action:@selector(refreashList) forControlEvents:UIControlEventTouchUpInside] ;
            return cell;
        }
            break;
            
        default:{
            MoreHotCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"HotCell"];
            if (dataModel) {
                cell.model = dataModel.arr[indexPath.row-3];
                [cell configWithModel];
            }
            NSMutableArray *arr  = [[MYBaseInfo defaultManager] refreash];
            if ([arr containsObject:cell.model.uid]) {
                cell.isattention.selected = YES;
            }else{
                cell.isattention.selected = NO;
            }
            cell.backgroundColor = [UIColor clearColor];
            cell.backView.image = [UIImage imageNamed:@"粉红.png"];
            return cell;
            }
            break;
    }
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return SCREEN_WIDTH/5*2 + 20;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 30;
            break;
        default:
            return 90;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<3) {
        return;
    }
    currChoose =(int) indexPath.row-3;
    [self performSegueWithIdentifier:@"gotoPerInfo" sender:self];
}
-(void)typeBtnPressed:(UIButton *)button{
    if (button.tag==101) {
        typeStr = @"新人榜";
        [MobClick event:@"rankNew"];

    }else if (button.tag==102){
        typeStr = @"活跃榜";
        [MobClick event:@"rankLive"];

    }else{
        
        typeStr = button.titleLabel.text;

        NSArray *types = @[@"时尚",@"美食",@"搞笑",@"娱乐",@"明星",@"游戏",@"旅游",@"健康",@"宠物",@"科技"];
        NSArray *typesEven = @[@"rankFashion",@"rankFood",@"rankWag",@"rankRelax",@"rankStar",@"rankGame",@"rankToursim",@"rankHealth",@"rankPet",@"rankTechnology"];
        NSInteger index = [types indexOfObject:typeStr];
        [MobClick event:typesEven[index]];

    }
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"gotoType" sender:self];
    self.hidesBottomBarWhenPushed = NO;

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"gotoType"])
    {////这里toVc是拉的那条线的标识符
        
         RankTypeLIstViewController *theVc = segue.destinationViewController;
            theVc.narStr = typeStr;
        if ([typeStr isEqualToString:@"新人榜"]) {
            theVc.type=@"2";
            theVc.tag = @"新人榜";
        }else
        if ([typeStr isEqualToString:@"活跃榜"]) {
            theVc.type=@"3";
            theVc.tag = @"活跃榜";

        }else{
            theVc.tag = typeStr;
            theVc.type=@"1";

        }
        theVc.api = @"member/getclassify";
        
    }
    
    
    
    if ([segue.identifier isEqualToString:@"gotoPerInfo"]){
        RankLIstPerInfoTableViewController *theVc = segue.destinationViewController;
        theVc.uid = dataModel.arr[currChoose].uid ;
    }

}
-(void)refreashList{
    
    [SVProgressHUD  show];
        

    [MoreHotNewWork getListWithType:@"2" success:^(MoreHotModel *model) {
        NSDictionary *RankList =  [MYObjectToNsDictionary getObjectData:model];
        
        DEF_PERSISTENT_SET_OBJECT(RankList, @"RankList");
        dataModel = model;
        [_listTabview reloadData];
        [SVProgressHUD  dismiss];
    }];
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
