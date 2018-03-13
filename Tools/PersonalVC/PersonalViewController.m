//
//  PersonalViewController.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "PersonalHeadTableViewCell.h"
#import "MoreHotRecomVC.h"
#import "MoreHotRecomVC.h"
#import "HomeNet.h"
#import "UIButton+WebCache.h"
#import "RankTypeLIstViewController.h"
#import <YWFeedbackFMWK/YWFeedbackKit.h>

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIWebView *_webView;
    PersonnalModel *dataModel;
    NSString *navStr;
    NSString *type;
    
    PersonalHeadTableViewCell *headCell;
    
    
    
}
@property (nonatomic, strong) YWFeedbackKit *feedbackKit;

@end

@implementation PersonalViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [HomeNet getallAttentionsuccess:^(NSArray *arr) {
//        DEF_PERSISTENT_SET_OBJECT(arr, @"ATTENARR");
//        if (headCell) {
//            headCell.attentionNumber.text = [NSString stringWithFormat:@"%ld人",arr.count];
//        }
//        [SVProgressHUD dismiss];
//    }];
//    NSError *err;
//    dataModel = [[PersonnalModel alloc]initWithDictionary: DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
//    headCell.headImage.imageView.contentMode = UIViewContentModeScaleToFill;
//    
//    headCell.attentionNumber.text = [NSString stringWithFormat:@"%@人",dataModel.followtotal];
//    headCell.fansNumber.text = [NSString stringWithFormat:@"%@人",dataModel.fanstotal];
//    headCell.nickName.text = dataModel.nickname;
//    headCell.cityLable.text = [NSString stringWithFormat:@"%@%@",dataModel.live_province,dataModel.live_city];
//    

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ZJ_CustomNaviRightButton:nil];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.title = @"个人中心";
    [self ZJ_CustomNaviRightButton:@"注销"];
    [self.navigationController.navigationBar setTitleTextAttributes:

    @{NSFontAttributeName:[UIFont systemFontOfSize:19],
      
      NSForegroundColorAttributeName:[UIColor whiteColor    ]}];
    
    
    NSError *err;
    dataModel = [[PersonnalModel alloc]initWithDictionary: DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];

    _perTab.delegate =self;
    _perTab.dataSource =self;
    [_perTab registerNib:[UINib nibWithNibName:@"PersonalTableViewCell" bundle:nil] forCellReuseIdentifier:@"personCell"];
    [_perTab registerNib:[UINib nibWithNibName:@"PersonalHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"personHeadCell"];
//    [SVProgressHUD show];
    
    headCell = [_perTab   dequeueReusableCellWithIdentifier:@"personHeadCell"];
    [headCell.headImage sd_setImageWithURL:[NSURL URLWithString:dataModel.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logopl"]];
    headCell.nickName.text = dataModel.nickname;
    headCell.cityLable.text = [NSString stringWithFormat:@"%@%@",dataModel.live_province,dataModel.live_city];

//    [headCell.headImage sd_setImageWithURL:[NSURL URLWithString:dataModel.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logopl"]];
//    headCell.attentionNumber.text = [NSString stringWithFormat:@"%@人",dataModel.followtotal];
//    headCell.fansNumber.text = [NSString stringWithFormat:@"%@人",dataModel.fanstotal];
//    headCell.nickName.text = dataModel.nickname;
//    headCell.cityLable.text = [NSString stringWithFormat:@"%@%@",dataModel.live_province,dataModel.live_city];
    
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 220  -  320/3+SCREEN_WIDTH/3;
    }
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
        [headCell.addAttentionBtn addTarget:self action:@selector(addAtten) forControlEvents:UIControlEventTouchUpInside];
        [headCell.attentionMeBtn addTarget:self action:@selector(attentionMe) forControlEvents:UIControlEventTouchUpInside];
        headCell.backgroundColor = [UIColor clearColor];
        return headCell;
    }
    PersonalTableViewCell *cell = [_perTab   dequeueReusableCellWithIdentifier:@"personCell"];
    cell.backgroundColor = [UIColor clearColor];
    switch (indexPath.row) {
        case 1:{

            [cell.titleImage setImage:[UIImage imageNamed:@"pipi-昵称"]];
            cell.perTitleLable.text = @"我的资料";
            return cell;
            break;
        }
        case 2 :{
            [cell.titleImage setImage:[UIImage imageNamed:@"反馈"]];
            cell.perTitleLable.text = @"我的收藏";
            return cell;
            break;
        }
            
        case 3:{
            [cell.titleImage setImage:[UIImage imageNamed:@"联系我们"]];
            cell.perTitleLable.text = @"联系我们";
            return cell;
            break;
        } case 4:{
            [cell.titleImage setImage:[UIImage imageNamed:@"好评"]];
            cell.perTitleLable.text = @"给个好评";
            return cell;
            break;
        } case 5 :{
            [cell.titleImage setImage:[UIImage imageNamed:@"反馈"]];
            cell.perTitleLable.text = @"用户反馈";
            return cell;
            break;
        }
     
            
        default:
            return nil;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:{
            [self performSegueWithIdentifier:@"reSetInfo" sender:self];
            [MobClick event:@"personalMyinfo"];

        }
            
            break;
        case 2:
        {
            [MobClick event:@"personalMyAttention"];

            [self GotoaddAttenList];
        }
            break;
        case 3: {

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"客服电话：028-85330993" preferredStyle:UIAlertControllerStyleAlert];
            
            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"立即拨打" style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) {
                
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"028-85330993"];
                UIWebView *callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"暂不拨打" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            
            [self presentViewController:alertController animated:YES completion:nil];

        }
            break;
        case 4:
        {
            [MobClick event:@"personalComment"];

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"给个好评" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
            break;
        case 5:
        {
            [MobClick event:@"personalFeedBack"];

            _feedbackKit =  [[YWFeedbackKit alloc] initWithAppKey:@"23495421"];
             [self _openFeedbackViewController];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户反馈" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
//            [alert show];
        }
            break;


            
        default:
            break;
    }
        }
- (void)_openFeedbackViewController
{
    __weak typeof(self) weakSelf = self;
    
    [_feedbackKit makeFeedbackViewControllerWithCompletionBlock:^(YWFeedbackViewController *viewController, NSError *error) {
        if ( viewController != nil ) {
//#warning 这里可以设置你需要显示的标题
            viewController.title = @"反馈界面";
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            [weakSelf presentViewController:nav animated:YES completion:nil];
            
            viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(actionQuitFeedback)];

//            
            __weak typeof(nav) weakNav = nav;
            
            [viewController setOpenURLBlock:^(NSString *aURLString, UIViewController *aParentController) {
                UIViewController *webVC = [[UIViewController alloc] initWithNibName:nil bundle:nil];
                UIWebView *webView = [[UIWebView alloc] initWithFrame:webVC.view.bounds];
                webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                
                [webVC.view addSubview:webView];
                [weakNav pushViewController:webVC animated:YES];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:aURLString]]];
            }];
        } else {
//            NSString *title = [error.userInfo objectForKey:@"msg"]?:@"接口调用失败，请保持网络通畅！";
//            [[TWMessageBarManager sharedInstance] showMessageWithTitle:title description:nil
//                                                                  type:TWMessageBarMessageTypeError];
        }
    }];
}
- (void)actionQuitFeedback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ZJ_CustomNaviRightButtonClicked{
    [MobClick event:@"logout"];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你真的要离我而去了吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"潇洒离去" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        DEF_PERSISTENT_SET_OBJECT(nil, @"peronInfoDetail");
//        DEF_PERSISTENT_SET_OBJECT(nil, @"Token");

        if (self.tabBarController.parentViewController) {
            [self dismissViewControllerAnimated:NO completion:^{
                //添加 字典，将label的值通过key值设置传递
                NSDictionary *dict = @{@"tong":@"zhi"}   ;//创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }];
        }else{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            UINavigationController *firstController = [story instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.tabBarController presentViewController:firstController animated:NO completion:^{
                [self.tabBarController setSelectedIndex:0];
            }];
        }
        [MobClick event:@"loginoutSure"];


    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"暂时留下" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MobClick event:@"loginoutCancel"];

    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
-(void)GotoaddAttenList{
    navStr =@"我的关注";
    type =@"2";
    [self performSegueWithIdentifier:@"gotoMyAtten" sender:self];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if(scrollView.contentOffset.y<0) {
        scrollView.contentOffset = CGPointMake(0, 0);
        //往下拉是小于0
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
