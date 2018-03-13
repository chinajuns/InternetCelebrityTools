//
//  MoreHotRecomVC.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MoreHotRecomVC.h"
#import "MoreHotCell.h"
#import "HomeViewController.h"
#import "CustomTabbarViewController.h"
#import "MoreHotNewWork.h"

@interface MoreHotRecomVC ()<UITableViewDelegate,UITableViewDataSource>{
//    UIImageView *navBarHairlineImageView;;
    MoreHotModel *dataModel;
    NSMutableArray *idArr;

}
@property (weak, nonatomic) IBOutlet UITableView *hotList;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation MoreHotRecomVC
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    navBarHairlineImageView.hidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    navBarHairlineImageView.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor whiteColor   ]}];

//
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    
    
    [SVProgressHUD show];
    
    [MoreHotNewWork getListWithType:@"1" success:^(MoreHotModel *model) {
        dataModel = model;
        [idArr removeAllObjects];
        for (HotPersonModel *permodel in  dataModel.arr) {
            [idArr addObject:permodel.uid];
        }
        [_hotList reloadData];
        [SVProgressHUD dismiss];
    }];
        [self ZJ_CustomNaviRightButton:@"换一批"];
    _nextBtn.layer.cornerRadius  =8 ;
    _nextBtn.clipsToBounds = YES;
//    _nextBtn.layer.borderColor = [UIColor colorWithHexString:@"FF8F9D"].CGColor;;
//    _nextBtn.layer.borderWidth=1;
    self.title  = _navStr;
    idArr  = [[NSMutableArray alloc]init];
    _hotList.delegate =self;
    _hotList.dataSource =self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ZJ_CustomNaviRightButtonClicked{
    [SVProgressHUD show];

    [MoreHotNewWork getListWithType:@"1" success:^(MoreHotModel *model) {
        dataModel = model;
        [idArr removeAllObjects];
        for (HotPersonModel *permodel in  dataModel.arr) {
            [idArr addObject:permodel.uid];
        }
        [_hotList reloadData];
        [SVProgressHUD dismiss];
    }];}

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
            if ([idArr containsObject:cell.model.uid]) {
                cell.isattention.selected = YES;
            }else{
                cell.isattention.selected = NO;
            }

    }
    cell.isattention.tag = 100+indexPath.row;
    [cell.isattention removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [cell.isattention addTarget:self action:@selector(addAtt:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 90.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    
}
- (IBAction)nextStepPressed:(id)sender {
    [SVProgressHUD show];
    [MoreHotNewWork addAttentionWIthIDArr:idArr success:^{
        
        if (self.navigationController.parentViewController) {
            [self dismissViewControllerAnimated:NO completion:^{
                NSLog(@"DISMISS")

            }];
        }else{
            [self performSegueWithIdentifier:@"gotoHomePage" sender:self];
        }

        [SVProgressHUD dismiss];
    }];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"gotoHomePage"])
    {////这里toVc是拉的那条线的标识符
        if ([_userType isEqualToString:@"商家"]) {
            CustomTabbarViewController   *theVc = segue.destinationViewController;
            [theVc setSelectedIndex:1];
        }
    }
}

- (void)tongzhi:(NSNotification *)text{
    NSLog(@"－－－－－接收到通知------");
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
- (void)ZJ_CustomNaviLeftButtonClicked {
//    self.navigationController popToViewController:[] animated:<#(BOOL)#>
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addAtt:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [idArr addObject:dataModel.arr[btn.tag-100].uid];
    }else{
        [idArr removeObject:dataModel.arr[btn.tag-100].uid];

    }
    
    
}

@end
