//
//  TextResultViewController.m
//  网红评估工具
//
//  Created by More on 16/10/8.
//  Copyright © 2016年 More. All rights reserved.
//

#import "TextResultViewController.h"
#import "ClaimActionSHeet.h"
#import "ResultTopTableViewCell.h"
#import "ResultShareTableViewCell.h"
#import "HomeNet.h"
#import "UILabel+LabelHeightAndWidth.h"
#import <PopMenu.h>
#import "LoopProgressView.h"
@interface TextResultViewController ()<UITableViewDelegate,UITableViewDataSource>{
    PersonnalModel *dataModel;
    UILabel *resultLbal;
    ResultTopTableViewCell  *cell;
    NSString *imageUrl;
    NSMutableAttributedString  *attstr;
    NSArray *contentArr;
    NSString *titleStr;
}
@property (weak, nonatomic) IBOutlet UITableView *resultTab;
//@property (weak, nonatomic) IBOutlet UILabel *numberLable;

@end

@implementation TextResultViewController
-(void)refBtnPressed{
    [SVProgressHUD show];
    [BaseNetWork getdataWithString:@"member/getcontent" parameters:nil scuccessBlock:^(NSDictionary *result) {
//        NSError* err = nil;
        dataModel = [[PersonnalModel alloc]init];
        dataModel.content = result[@"content"];
        dataModel.influence_ranking = result[@"influence_ranking"];
        dataModel.usertotal = result[@"usertotal"];
        dataModel.valuations = result[@"valuations"];

        NSString *temStr =  [ result[@"content"] stringByReplacingOccurrencesOfString:@"--n" withString:@"\n"];;
        contentArr = [temStr componentsSeparatedByString:@"_pic_"] ;
        if (contentArr.count>1) {
            imageUrl =          [contentArr objectAtIndex:1];
            [cell.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"logopl"]];
        }else{
            cell.headImage.hidden = YES;
        }
        attstr =[[NSMutableAttributedString alloc]initWithString:contentArr[0]];
        if( [temStr rangeOfString:@"魅力优势："].location != NSNotFound){

        [attstr addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexString:@"FF8F9D"] range:[temStr rangeOfString:@"魅力优势："]];
        }
        if( [temStr rangeOfString:@"环境优势："].location != NSNotFound){

        [attstr addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexString:@"FF8F9D"] range:[temStr rangeOfString:@"环境优势："]];
        }
        if( [temStr rangeOfString:@"发展优势："].location != NSNotFound){
            [attstr addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexString:@"FF8F9D"] range:[temStr rangeOfString:@"发展优势："]];
 
        }
        if( [temStr rangeOfString:@"红人路标："].location != NSNotFound){

        [attstr addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexString:@"FF8F9D"] range:[temStr rangeOfString:@"红人路标："]];
        }
        
       
        cell.persentLable.attributedText =attstr;
//
        cell.rankLable.text = [NSString stringWithFormat:@" %@位 ",dataModel.influence_ranking];
        
        temStr = contentArr[0];
//        NSLog(@"%@", )  ;
        LoopProgressView   *custom = [[LoopProgressView alloc]initWithFrame:cell.rankLable.frame];
        
        custom = [[LoopProgressView alloc]initWithFrame:cell.rankLable.frame];
        
        
        custom.progress = 1;
    
        
        [cell insertSubview:custom belowSubview:cell.rankLable];
        
        

        titleStr = [NSString stringWithFormat:@"好赞！我的红人之路已开启，当前价值为%@，即将成为下一个%@。快下载红人墙检测你的价值吧。",dataModel.valuations,[temStr componentsSeparatedByString:@"\""][1]];
        [_resultTab reloadData];
        [SVProgressHUD dismiss];
    } fail:^{
        [SVProgressHUD dismiss];

    }];
    
}
- (void)drawRoundView {
     ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ZJ_CustomNaviRightButtonWithImage:[UIImage imageNamed:@"分享"]];

//    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"关闭"]];
    [self refBtnPressed];
    _resultTab.delegate =self;
    _resultTab.dataSource = self;
    dataModel = [[PersonnalModel alloc]init];
    dataModel.influence_ranking = @"0";

    [_resultTab registerNib:[UINib nibWithNibName:@"ResultTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"TopCell"];
    cell      =  [_resultTab dequeueReusableCellWithIdentifier:@"TopCell"];
//    [self animation2];
    //    [_re sultTab registerNib:[UINib nibWithNibName:@"ResultShareTableViewCell" bundle:nil] forCellReuseIdentifier:@"SHareCell"];
//     =  [_resultTab dequeueReusableCellWithIdentifier:@"TopCell"];
//  
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [MobClick event:@"evaluateResultBack"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        cell.rankLable.text = [NSString stringWithFormat:@" %@位 ",dataModel.influence_ranking];

        cell.backgroundColor = [UIColor clearColor];
        return cell;
}

-(NSString *)GetTomorrowDay:(NSDate *)aDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init] ;
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 400 - 2*107 + (SCREEN_WIDTH/3)*3 - 17 + [UILabel getHeightByWidth:SCREEN_WIDTH-2*16 title:contentArr[0] font:[UIFont systemFontOfSize:16]];
}

-(void)ZJ_CustomNaviRightButtonClicked{
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"新浪微博" iconName:@"M新浪.png" index:0];
    
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"朋友圈" iconName:@"M朋友圈.png" index:1];
    
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"微信好友" iconName:@"M微信.png" index:2];
    
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc]  initWithTitle:@"QQ好友" iconName:@"MFQQ.png" index:3];
    [items addObject:menuItem];
    
    
    
    PopMenu *popMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) items:items];
    popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
        [self shareToPlaWithTag:(int)selectedItem.index];
    };
    popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase; // kPopMenuAnimationTypeSina
    popMenu.perRowItemCount = 2; // or 2
    [popMenu showMenuAtView:self.tabBarController.view];
    
    
}
#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
//    [shareBack removeFromSuperview];
//    [shareView removeFromSuperview];
}

-(void)shareToPlaWithTag:(int)tag{
//    [MobClick event:@"homeShare"];
    [MobClick event:@"shareEvaResult"];

    switch (tag) {
        case 0:{
            
            [[UMShare defaultManager] shareWebPageToPlatformType:UMSocialPlatformType_Sina  withTitle:titleStr  success:^{
            }];
            break;
            
        }
        case 1:{
            [[UMShare defaultManager]shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine   withTitle:titleStr success:^{
                
            }];
            break;
            
        }
        case 2:{
            [[UMShare defaultManager]shareWebPageToPlatformType:UMSocialPlatformType_WechatSession   withTitle:titleStr success:^{
                
            }];
            break;
        }
            
        case 3:{
            [[UMShare defaultManager]shareWebPageToPlatformType:UMSocialPlatformType_QQ   withTitle:titleStr success:^{
                
            }];
            break;
            
        }
        default:
            break;
    }
    
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
