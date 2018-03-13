//
//  RankLIstPerInfoTableViewController.m
//  网红评估工具
//
//  Created by More on 16/10/8.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RankLIstPerInfoTableViewController.h"
#import "ClaimActionSHeet.h"
#import "MistakeActionSheet.h"
#import "RankIamgesTableViewCell.h"
#import "RankMoreInfoTableViewCell.h"
#import "MoreInfoViewController.h"
#import "PersonalInfoNet.h"
#import "UIButton+WebCache.h"
#import "SDCycleScrollView.h"
#import "SDPhotoBrowser.h"
#import "RegisterDetailInfoVC.h"
#import "RegisterDetailInfoVC.h"
@interface RankLIstPerInfoTableViewController ()<UITableViewDelegate,UITableViewDataSource,SDPhotoBrowserDelegate>{
    PersonalInforDetailModel *dataModel;
    
    NSMutableArray *imagesArr;
    RankMoreInfoTableViewCell *InfoCell;

}
@property (weak, nonatomic) IBOutlet UIView *imagesView;

@end

@implementation RankLIstPerInfoTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;


    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    if ( !InfoCell.addAttention.selected) {
        NSMutableArray *arr  = [[MYBaseInfo defaultManager] refreash];
        if ([arr containsObject:dataModel.uid]) {
            [HomeNet delAttentionWithID:dataModel.uid success:^{
                [SVProgressHUD dismiss];
                
            }];
            [[MYBaseInfo defaultManager] delAttenWIthUid:dataModel.uid];

        }
      
    }else{
        NSMutableArray *arr  = [[MYBaseInfo defaultManager] refreash];
        if (![arr containsObject:dataModel.uid]) {

//        [SVProgressHUD showWithStatus:@"正在添加关注"];
        
        [HomeNet addAttentionWithID:dataModel.uid success:^{
            //            _isattention.selected = YES;
            [SVProgressHUD dismiss];
        }];
            [[MYBaseInfo defaultManager] addAttenWIthUid:dataModel.uid];

        }
    }
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人主页";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    imagesArr = [[NSMutableArray alloc]init];
    [SVProgressHUD show];
    [PersonalInfoNet getUserInfoDetailWithUid:_uid Success:^(PersonalInforDetailModel *model) {
        dataModel = model;
        [_perTab reloadData];
        [SVProgressHUD dismiss];
        if ([dataModel.user_type integerValue]==3) {
            [self ZJ_CustomNaviRightButton:@"我要认领"];
            
        }
        for (NSString * str  in dataModel.picture) {
            if (str.length==0) {
                continue;
            }else{
                [imagesArr addObject:str];
            }
        }


    } fainBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];

   
    _perTab.delegate = self;
    _perTab.dataSource = self;
    
    
    [_perTab registerNib:[UINib nibWithNibName:@"RankIamgesTableViewCell" bundle:nil] forCellReuseIdentifier:@"LIstTableViewCell"];
       [_perTab registerNib:[UINib nibWithNibName:@"RankMoreInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoreInfoTableViewCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ZJ_CustomNaviLeftButtonClicked{
    [MobClick event:@"personalInfoBack"];

    
    NSInteger count = self.navigationController.viewControllers.count;
    if ([self.navigationController.viewControllers[count-2] isKindOfClass:[MoreInfoViewController class]]) {
        [self.tabBarController setSelectedIndex:1];

        [self.navigationController popToRootViewControllerAnimated:YES];

    }else{
        [self.navigationController popViewControllerAnimated:YES];

    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (dataModel) {

        return 2;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        RankIamgesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LIstTableViewCell"];

            if (imagesArr.count!=0) {
                CGFloat  width  = (SCREEN_WIDTH-25)/4.0;
                for (int i = 0; i < imagesArr.count; i++) {
                    UIButton  *image = [[UIButton alloc]initWithFrame:CGRectMake(i%4*width+(i%4+1)* 5, i/4*width +(i/4+1)* 5 ,width, width)];
                    [image sd_setImageWithURL:imagesArr[i] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logopl"]];
                    image.imageView.contentMode = UIViewContentModeScaleAspectFill;
                    image.clipsToBounds = YES;
                    image.layer.cornerRadius = 5;
                    image.clipsToBounds = YES;
                    image.tag=100+i;
                    [image addTarget:self action:@selector(showPhotoBrower:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:image];
                    
                }
                
            }else{
                CGFloat  width  = (SCREEN_WIDTH-25)/4.0;

                UIButton  *image = [[UIButton alloc]initWithFrame:CGRectMake( 5,  5 ,width, width)];
                NSError *err;
//               PersonnalModel * dataModel = [[PersonnalModel alloc]initWithDictionary: DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
                
                [image sd_setImageWithURL:[NSURL URLWithString:dataModel.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logopl"]];
                image.imageView.contentMode = UIViewContentModeScaleAspectFill;
                image.clipsToBounds = YES;
                image.layer.cornerRadius = 5;
                image.clipsToBounds = YES;
                image.tag=100;
                [image addTarget:self action:@selector(showPhotoBrower:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:image];

            }
        

        return cell;
        
    }else{
        InfoCell = [tableView dequeueReusableCellWithIdentifier:@"MoreInfoTableViewCell"];
        InfoCell.datamodel = dataModel;
    
        if (dataModel) {
            [InfoCell configWithModel:dataModel];
        }
        NSError *err= nil;
        PersonnalModel *perModel = [[PersonnalModel alloc]initWithDictionary: DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
        if ([dataModel.uid   isEqualToString:perModel.uid]) {
            InfoCell.addAttention .hidden= YES;
        }
        [InfoCell.moreInfoBtn addTarget:self action:@selector(getMoreInforMation) forControlEvents:UIControlEventTouchUpInside];
        
        for(int i = 0 ;i< (dataModel.fans.count  > 6 ?6 :dataModel.fans.count);i ++){
            UIButton *image = [[UIButton alloc]initWithFrame:CGRectMake(10 + i * 50, 490, 40, 40)];

            [image sd_setImageWithURL:[NSURL URLWithString:dataModel.fans[i][@"head"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logopl"]];
            image.tag = 100+i;
            [image addTarget:self action:@selector(gotoPerson:) forControlEvents:UIControlEventTouchUpInside];
            image.layer.cornerRadius =20;
            image.clipsToBounds = YES;
            [InfoCell addSubview:image];
            
        }
        for (NSString *key in dataModel.data) {
            if ([key isEqualToString:@"weibo"]) {
                UIButton *image = [[UIButton alloc]initWithFrame:CGRectMake(92, 246, 200, 17)];
                image.titleLabel.font = [UIFont systemFontOfSize:14];
                [image setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
                [image setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                [image setTitle:[NSString stringWithFormat:@" %@",[self countNumAndChangeformat:dataModel.data[key][@"fans"]]] forState:UIControlStateNormal];
                [InfoCell addSubview:image];
                
            }
        }
        return InfoCell;
    }
    
}
- (void)ZJ_CustomNaviRightButtonClicked{
    [MobClick event:@"reclaim"];
    ClaimActionSHeet *typesheet = [[ClaimActionSHeet alloc] initWithFrame:self.navigationController.view.bounds];
    typesheet.uid = _uid;
    typesheet.GetSelectDate = ^(NSDictionary *Result) {
        [MobClick event:@"reclaimSubmit"];

    };
    [self.navigationController.view addSubview:typesheet];
}
- (IBAction)getMistake:(id)sender {
    [MobClick event:@"makeMistake"];

    MistakeActionSheet *typesheet = [[MistakeActionSheet alloc] initWithFrame:self.navigationController.view.bounds];
    typesheet.uid = _uid;

    typesheet.GetSelectDate = ^(NSDictionary *Result) {
        [MobClick event:@"makeMIstakeSub"];

        //        [sizeCell.hipsSizeBtn setTitle:Result forState:UIControlStateNormal];
    };
    [self.navigationController.view addSubview:typesheet];
    
}
- (IBAction)haveCoor:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"邀约红人合作，请先提交申请资料哦！" preferredStyle:UIAlertControllerStyleAlert];

     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"去提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RegisterDetailInfoVC *vc = [[RegisterDetailInfoVC alloc]init];
        vc.type=0;
        vc.uid = _uid;
        vc.title =@"诚邀合作";
        [MobClick event:@"haveCor"];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:okAction];

    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
//     CooperationActionSheet *typesheet = [[CooperationActionSheet alloc] initWithFrame:self.navigationController.view.bounds];
//    typesheet.uid = _uid;
//
//    typesheet.GetSelectDate = ^(NSDictionary *Result) {
//        //        [sizeCell.hipsSizeBtn setTitle:Result forState:UIControlStateNormal];
//    };
//    [self.navigationController.view addSubview:typesheet];
    
}
- (void)getMoreInforMation {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"查看红人更多资料需要先验证自己的信息哦！" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        
        [MobClick event:@"moreInfo"];
        
        RegisterDetailInfoVC *vc = [[RegisterDetailInfoVC alloc]init];
        vc.type=1;
        vc.uid = _uid;
        vc.title =@"查看更多资料";
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];

    [self presentViewController:alertController animated:YES completion:nil];

 
//    MoreInfoActionSheet *typesheet = [[MoreInfoActionSheet alloc] initWithFrame:self.navigationController.view.bounds];
//    typesheet.uid = _uid;
//
//    typesheet.GetSelectDate = ^(NSDictionary *Result) {
//        
//    };
//    [self.navigationController.view addSubview:typesheet];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            if (imagesArr.count==0) {
                CGFloat  width  = (SCREEN_WIDTH-25)/4.0;
                return width+10;

            }if (imagesArr.count<=4) {
                CGFloat  width  = (SCREEN_WIDTH-25)/4.0;
                return width+10;
            }else{
                CGFloat  width  = (SCREEN_WIDTH-25)/4.0;
                return 2*width+15;
                
            }
            return  SCREEN_WIDTH/4*3;
            return 0;
            break;
    
        default:
            return 540;
            break;
    }
}
-(void)gotoPerson:(UIButton *)btn {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RankLIstPerInfoTableViewController *vc = [story instantiateViewControllerWithIdentifier:@"RankLIstPerInfoTableViewController"];
    
    vc.uid = dataModel.fans[btn.tag-100][@"uid"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  SDPhotoBrowserDelegate
-(void)showPhotoBrower:(UIButton *)sender{
 
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = sender.tag-100;
    if(imagesArr.count==0){
        photoBrowser.imageCount = 1;
    }else{
        photoBrowser.imageCount = imagesArr.count;
    }
    
    RankIamgesTableViewCell *cell = [_perTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    photoBrowser.sourceImagesContainerView =  cell.contentView;
    [photoBrowser show];
}
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{

    return [UIImage imageNamed:@"logopl"];
    
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
//    NSString *urlStr = [[self.modelsArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    if(imagesArr.count==0){
        return [NSURL URLWithString:dataModel.head];
    }else{
        return imagesArr[index];
    }
}
-(NSString *)countNumAndChangeformat:(NSString *)num
{
    float a = 0.0;
    if (num.integerValue > 10000) {
        a = num.integerValue/10000.0;
        return [NSString stringWithFormat:@"%.2fw",a];
    }else{
        return num;
    }
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
