//
//  MoreInfoViewController.m
//  网红评估工具
//
//  Created by More on 16/9/30.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MoreInfoViewController.h"
//#import "FirstStupCell.h"
#import "ExcelledCell.h"
#import "OtherIDTableViewCell.h"
#import "NoteTableViewCell.h"
//#import "EVAFooterTableViewCell.h"
#import "SeleBtn.h"
#import "PersonalViewController.h"
#import "HomeNet.h"
#import "EvaluateNet.h"
#import "MoreTypeOtherTableViewCell.h"
#import "MoreTypeChooseVC.h"
#import "MorePlatformVc.h"
#import "ClaimListVC.h"
#import "AlertSheet.h"
@interface MoreInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
//    UIImageView *navBarHairlineImageView;;
    OtherIDTableViewCell *ThirdCell;
    ExcelledCell *plasCell;//平台
    ExcelledCell *beGoodCell ;///擅长
    ExcelledCell *busCell ;//商业
    ExcelledCell *incomeCell ;//商业

    UIView *moreBeGoodView;
    UIView *morePlaView;

    
    NSMutableDictionary *par;
    
    PersonnalModel *dataModel;
    NoteTableViewCell *noteCell;
    
    
    MoreTypeOtherTableViewCell *otherCell;
    
    NSArray *typePYArr;
    NSArray *typeArr;

    
    NSDictionary *temDic;

}
@property (weak, nonatomic) IBOutlet UITableView *moreInfoTab;

@end

@implementation MoreInfoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    
//    navBarHairlineImageView.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
//    navBarHairlineImageView.hidden = NO;
    
}
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets= NO;
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:[PersonalViewController class]]) {
        self.title = @"个人资料";
    }else{
        self.title = @"我的评测";
    }
    NSError *err;
    dataModel = [[PersonnalModel alloc]initWithDictionary: DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];

    par = [NSMutableDictionary dictionaryWithDictionary:@{

                                                                      @"desc":dataModel.desc,//北至呼
                                                                      @"tags":dataModel.tags,//标签，结构：网球,排球；默认已分号结尾
                                                                      @"income":dataModel.income,//收入 同标签
                                                                      @"business":dataModel.business,//商业 同标签
                                                                      @"platform_info":dataModel.platform_info//平台 结构{name1:value1,name2:value2}
                                                          
                                                          
                                                          }];
    temDic=[[NSDictionary alloc]initWithDictionary:par];
    
    _moreInfoTab.delegate =self;
    _moreInfoTab.dataSource = self;
    [_moreInfoTab registerNib:[UINib nibWithNibName:@"FirstStupCell" bundle:nil] forCellReuseIdentifier:@"FirstCell"];
    [_moreInfoTab registerNib:[UINib nibWithNibName:@"ExcelledCell" bundle:nil] forCellReuseIdentifier:@"ExceCell"];
    [_moreInfoTab registerNib:[UINib nibWithNibName:@"OtherIDTableViewCell" bundle:nil] forCellReuseIdentifier:@"IDCell"];
    [_moreInfoTab registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoteCell"];
    [_moreInfoTab registerNib:[UINib nibWithNibName:@"EVAFooterTableViewCell" bundle:nil] forCellReuseIdentifier:@"EVAfooterCell"];
    [_moreInfoTab registerNib:[UINib nibWithNibName:@"TextNavCell" bundle:nil] forCellReuseIdentifier:@"navCell"];
    [_moreInfoTab registerNib:[UINib nibWithNibName:@"MoreTypeOtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"otherCell"];

    plasCell =[_moreInfoTab dequeueReusableCellWithIdentifier:@"ExceCell"];

    
    ThirdCell=[_moreInfoTab dequeueReusableCellWithIdentifier:@"IDCell"];
    ThirdCell.backgroundColor = [UIColor clearColor];
    
    plasCell.mainTitleLable.text=@"你常用的平台";
    plasCell.secondTitleLable.text=@"请选择您常用的平台";
    plasCell.backgroundColor = [UIColor clearColor];
    
    
    typePYArr = @[@"weixin",@"weibo",@"meipai",@"miaopai",@"yinke",@"bilibili"];
    typeArr  = @[@"微信公众号",@"新浪微博",@"美拍",@"秒拍",@"映客",@"bilibili"];
 
    NSMutableArray  *arr  = [[NSMutableArray alloc]init];
    NSMutableArray   *temArr =  [[NSMutableArray alloc]init];
    NSMutableDictionary *thirdPla = [[NSMutableDictionary alloc]init];
    
    for(NSString *key in dataModel.platform_info){
        NSString *plaName = dataModel.platform_info[key][@"name"];
        NSString *vaalue = dataModel.platform_info[key][@"pid"];
        if ([typePYArr containsObject:plaName]) {
            NSInteger index = [typePYArr indexOfObject:plaName];
            [temArr addObject:typeArr[index]];
            [arr addObject:typeArr[index]];
            [thirdPla setObject:vaalue forKey:typeArr[index]];

        }else
        {
            [temArr addObject:key];
            [arr addObject:key];
            [thirdPla setObject:vaalue forKey:plaName];


        }
    }
    
    ThirdCell.nameAndId = thirdPla;
    [ThirdCell refreaUIWithPlsArr: temArr];
    for (NSString *str  in @[@"新浪微博",@"微信公众号",@"美拍",@"秒拍"]) {
        if (![arr containsObject:str]) {
            [arr addObject:str];
        }
    }
    
  
    for ( int i=0 ; i<3; i++) {
        SeleBtn *button  = [[SeleBtn alloc]initWithFrame:CGRectMake(16+80*i /320.0*SCREEN_WIDTH, 66, 70 /320.0*SCREEN_WIDTH, 30   )];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font =  [ UIFont systemFontOfSize:12];
        button.layer.cornerRadius =3;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
        button.tag = 200+i;
        [button addTarget:self action:@selector(choosePla:) forControlEvents:UIControlEventTouchUpInside];
        if ([temArr containsObject:arr[i]]) {
            button.selected= YES;
            [button addSubview:button.topImage];
            [plasCell.seleArr addObject:arr[i]];
        }
        [plasCell addSubview:button];
    }
  

    [plasCell.moreBtn addTarget:self action:@selector(morePLa) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //擅长领域
    beGoodCell =[_moreInfoTab dequeueReusableCellWithIdentifier:@"ExceCell"];
    beGoodCell.backgroundColor = [UIColor clearColor];
    [arr removeAllObjects];
    [arr addObjectsFromArray:dataModel.tags];
    for (NSString *str  in @[@"明星",@"游戏",@"健康",@"科技"]) {
        if (![arr containsObject:str]) {
            [arr addObject:str];
        }
    }
    
    for ( int i=0 ; i<4; i++) {
        SeleBtn *button  = [[SeleBtn alloc]initWithFrame:CGRectMake(16+60*i /320.0*SCREEN_WIDTH, 66, 50 /320.0*SCREEN_WIDTH, 30   )];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font =  [ UIFont systemFontOfSize:12];
        button.layer.cornerRadius =3;
        button.layer.borderWidth = 1;
        button.tag = 100+i;
        button.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
        [button  addTarget:self action:@selector(chooseMoreBeGood:) forControlEvents:UIControlEventTouchUpInside];
        if ([dataModel.tags containsObject:arr[i]]) {
            button.selected= YES;
            [button addSubview:button.topImage];
            [beGoodCell.seleArr addObject:arr[i]];
        }
        [beGoodCell addSubview:button];
    }
    
    [beGoodCell.moreBtn addTarget:self action:@selector(moreInfoBegood:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    busCell =[_moreInfoTab dequeueReusableCellWithIdentifier:@"ExceCell"];
    incomeCell =[_moreInfoTab dequeueReusableCellWithIdentifier:@"ExceCell"] ;//收入
    
    
    incomeCell.mainTitleLable.text=@"请选择您现在的收入来源";
    incomeCell.secondTitleLable.text=@"";
    incomeCell.moreBtn.hidden =YES;
    incomeCell.backgroundColor = [UIColor clearColor];
//            NSArray *arr= @[@"电子商务合作（产品推广）",@"软文视频（节目冠名）",@"商业代言（肖像使用）",@"演出经纪（落地活动）"];
    [arr removeAllObjects];
    [arr addObjectsFromArray:dataModel.income];
    for (NSString *str  in @[@"电商合作",@"软文",@"视频",@"商业代言",@"演出经纪"]) {
        if (![arr containsObject:str]) {
            [arr addObject:str];
        }
    }
    
    for ( int i=0 ; i<5; i++) {
        SeleBtn *button  = [[SeleBtn alloc]initWithFrame:CGRectMake(16+70*(i%4) /320.0*SCREEN_WIDTH, i/4*40+46, 60 /320.0*SCREEN_WIDTH, 30   )];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font =  [ UIFont systemFontOfSize:12];
        button.layer.cornerRadius =3;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
        [button addTarget:self action:@selector(chooseIncome:) forControlEvents:UIControlEventTouchUpInside];
        if ([dataModel.income containsObject:arr[i]]) {
            button.selected= YES;
            [button addSubview:button.topImage];
            [incomeCell.seleArr addObject:arr[i]];
        }

        [incomeCell addSubview:button];
    }
    
    otherCell = [_moreInfoTab dequeueReusableCellWithIdentifier:@"otherCell"];
    otherCell.otherTextfield.placeholder = @"请填写其它能接受的类型，可不填";
    otherCell.otherTextfield.delegate = self;
    
    busCell.mainTitleLable.text=@"你能接受的商业类型";
    busCell.secondTitleLable.text=@"请选择你能接受的商业类型";
    busCell.backgroundColor = [UIColor clearColor];
    busCell.moreBtn.hidden = YES;
    
    [arr removeAllObjects];
    [arr addObjectsFromArray:dataModel.business];
//message:@"商务合作－产品推广\n软文视频－节目冠名\n商业代言－肖像使用\n演出经纪－落地活动"

    NSArray *busArr =@[@"电商合作",@"软文",@"视频",@"商业代言",@"演出经纪",@"其它"] ;
    
//    }
    for ( int i=0 ; i<busArr.count; i++) {
        SeleBtn *button  = [[SeleBtn alloc]initWithFrame:CGRectMake(16+70*(i%4)  /320.0*SCREEN_WIDTH, 66 + i/4*40, 60 /320.0*SCREEN_WIDTH, 30   )];
        [button setTitle:busArr[i] forState:UIControlStateNormal];
        button.titleLabel.font =  [ UIFont systemFontOfSize:12];
        button.layer.cornerRadius =3;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
        [button addTarget:self action:@selector(chooseBus:) forControlEvents:UIControlEventTouchUpInside];
        if ([dataModel.business containsObject:busArr[i]]) {
            button.selected= YES;
            [button addSubview:button.topImage];
            [busCell.seleArr addObject:busArr[i]];
        }
        if (i == busArr.count-1) {
            for (NSString *str  in dataModel.business) {

                if (![busArr containsObject:str]) {
                    otherCell.otherTextfield.text =str;
                    button.selected= YES;
                    [button addSubview:button.topImage];
                    [busCell.seleArr addObject:@"其它"];

                    
                }
            }
        }
        [busCell addSubview:button];
    }

    
    noteCell  =[_moreInfoTab dequeueReusableCellWithIdentifier:@"NoteCell"];
    if (dataModel.desc.length>0) {
        noteCell.noteTextfield.text = dataModel.desc;
        noteCell.plLable.hidden = YES;
    }
    noteCell.backgroundColor = [UIColor clearColor];

}
-(void)morePLa{

    [self performSegueWithIdentifier:@"morePla" sender:self];

}

-(void)moreInfoBegood:(UIButton *)btn{

    [self performSegueWithIdentifier:@"moreType" sender:self];

//    [self prepareForSegue:@"moreType" sender:self]；
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // segue.identifier：获取连线的ID
    if ([segue.identifier isEqualToString:@"moreType"]) {
        MoreTypeChooseVC *vc    = segue.destinationViewController;
        vc.getBeGoodArr= ^(NSArray *choosearr){
            ///移除原有Btn
            for (UIView *view in beGoodCell.subviews) {
                if (view.tag>=100) {
                    [view removeFromSuperview];
                }
            }
            ///刷新选择数组
            [beGoodCell.seleArr  removeAllObjects];
            [beGoodCell.seleArr addObjectsFromArray:choosearr];
            
            ///重新布局
            NSMutableArray *arr = [NSMutableArray arrayWithArray:choosearr];
            for (NSString *str  in @[@"明星",@"游戏",@"健康",@"科技"]) {
                if (![arr containsObject:str]) {
                    [arr addObject:str];
                }
            }
            for ( int i=0 ; i<4; i++) {
                SeleBtn *button  = [[SeleBtn alloc]initWithFrame:CGRectMake(16+60*i /320.0*SCREEN_WIDTH, 66, 50 /320.0*SCREEN_WIDTH, 30   )];
                [button setTitle:arr[i] forState:UIControlStateNormal];
                button.titleLabel.font =  [ UIFont systemFontOfSize:12];
                button.layer.cornerRadius =3;
                button.layer.borderWidth = 1;
                button.tag = 100+i;
                button.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
                [button  addTarget:self action:@selector(chooseMoreBeGood:) forControlEvents:UIControlEventTouchUpInside];
                if ([choosearr containsObject:arr[i]]) {
                    button.selected= YES;
                    [button addSubview:button.topImage];
                }
                [beGoodCell addSubview:button];
            }
            
            
        };
        vc.chooseArr = [NSMutableArray arrayWithArray:beGoodCell.seleArr];
    }
    if ([segue.identifier isEqualToString:@"morePla"]) {
        MorePlatformVc *vc    = segue.destinationViewController;
        vc.dataDic = [ThirdCell getHZInfo];
        
        
        
        vc.choosePlatS = ^(NSDictionary *dic){
            ThirdCell.nameAndId = dic;
            [ThirdCell refreaUIWithPlsArr: dic.allKeys];
          
            //局部cell刷新
            [plasCell.seleArr removeAllObjects];
          
//            [plasCell.seleArr addObjectsFromArray:dic.allKeys];
            
            [_moreInfoTab reloadData];

            for (UIView *view in plasCell.subviews) {
                if (view.tag>=200) {
                    [view removeFromSuperview];
                }
            }
            
            NSMutableArray *temArr = [NSMutableArray arrayWithArray:dic.allKeys];
            for (NSString *str  in @[@"新浪微博",@"微信公众号",@"美拍",@"秒拍"]) {
                if (![temArr containsObject:str]) {
                    [temArr addObject:str];
                }
            }
            
            for ( int i=0 ; i<3; i++) {
                SeleBtn *button  = [[SeleBtn alloc]initWithFrame:CGRectMake(16+80*i /320.0*SCREEN_WIDTH, 66, 70 /320.0*SCREEN_WIDTH, 30   )];
                [button setTitle:temArr[i] forState:UIControlStateNormal];
                button.titleLabel.font =  [ UIFont systemFontOfSize:12];
                button.layer.cornerRadius =3;
                button.layer.borderWidth = 1;
                button.layer.borderColor = [UIColor colorWithHexString:@"FF8481"].CGColor;
                button.tag = 200+i;
                [button addTarget:self action:@selector(choosePla:) forControlEvents:UIControlEventTouchUpInside];
                if ([dic.allKeys containsObject:temArr[i]]) {
                    button.selected= YES;
                    [button addSubview:button.topImage];
                    [plasCell.seleArr addObject:temArr[i]];
                }
                [plasCell addSubview:button];
            }
            
            
            

        } ;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {

        case 0:
        {
          
            return  beGoodCell;
            break;
        }
        case 1:
        {
            return  plasCell;
            break;
        }
        case 2:
        {
            if (plasCell.seleArr.count == 0) {
                ThirdCell.topLine.hidden=YES;
                ThirdCell.bottomLine.hidden=YES;
                
            }
            return  ThirdCell;
            break;
        }

        case 3:
        {
            incomeCell.questionBtn.hidden = NO;
            [incomeCell.questionBtn addTarget:self action:@selector(descriptionIncom) forControlEvents:UIControlEventTouchUpInside];
            return  incomeCell;
            break;
        }
        case 4:
        {
            return  busCell;
            break;
        }
        case 5:
        {
            otherCell.backgroundColor = [UIColor clearColor];

            if ([busCell.seleArr containsObject:@"其它"]) {
                for (UIView  *sub in otherCell.contentView.subviews) {
                    sub.hidden=NO;
                }
                
            }else{
                otherCell.otherTextfield.text = @"";
                for (UIView  *sub in otherCell.contentView.subviews) {
                    sub.hidden=YES;
                }
            }
            return  otherCell;
            break;
        }
            
        case 6:
        {
            return  noteCell;
            break;
        }
        default:
            return nil;
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    switch (indexPath.row) {
      
//        case 0:
//            return 0;
//            break;
        case 0:
            return 110;
            break;
        case 1:
            return 110;
            break;
        case 2:
         return 80 * plasCell.seleArr.count;
            return 0;
            break;
        case 3:
            return 70 +40;
            break;
        case 4:
            return 140;
            break;
        case 5:
            if ([busCell.seleArr containsObject:@"其它"]) {
                return 44;

            }else{
                return 0;
            }
            break;
        case 6:
            return 150;
            break;
        default:
            return 110;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (IBAction)nextStep:(id)sender {
   
    [MobClick event:@"chickEvaResult"];
    if ([busCell.seleArr containsObject:@"其它"]) {
        [busCell.seleArr removeObject:@"其它"];
    }
    
    if (beGoodCell.seleArr.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择呢擅长的领域" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (incomeCell.seleArr.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择你的收入来源" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (busCell.seleArr.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择你能接受的商业类型" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
 
    
    [par setObject:beGoodCell.seleArr forKey:@"tags"];
    [par setObject:incomeCell.seleArr forKey:@"income"];
    [par setObject:busCell.seleArr forKey:@"business"];
    [par setObject:noteCell.noteTextfield.text forKey:@"desc"];
    [par setObject:[ThirdCell getInfo]     forKey:@"platform_info"];
    
    
    if ([temDic isEqual:par]) {
        [self performSegueWithIdentifier:@"gotoResult" sender:self];

//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"您暂时没有做任何修改"
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];

        return;
    }
    
    [SVProgressHUD show];
    [EvaluateNet submitPerinfo:par Success:^(NSArray <HotPersonModel *> *date){
        [SVProgressHUD showWithStatus:@"保存成功"];
        [SVProgressHUD dismissWithDelay:1];

        if (date.count!=0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"Sorry，您填写的昵称已经存在，赶紧去认领吧" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂时不认领" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self performSegueWithIdentifier:@"gotoResult" sender:self];
        
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去认领" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                 ClaimListVC *vc = [story instantiateViewControllerWithIdentifier:@"ClaimListVC"];
                vc.dataArr = date;

                [self.navigationController pushViewController:vc animated:YES];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            [self performSegueWithIdentifier:@"gotoResult" sender:self];

        }
        
    }];


}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [MobClick event:@"moreinfoBack"];

    [par setObject:beGoodCell.seleArr forKey:@"tags"];
    [par setObject:incomeCell.seleArr forKey:@"income"];
    [par setObject:busCell.seleArr forKey:@"business"];
    [par setObject:noteCell.noteTextfield.text forKey:@"desc"];
    [par setObject:[ThirdCell getInfo]     forKey:@"platform_info"];
    
    bool ischange = NO;
    
    for (NSString *str  in  temDic) {
        if ([str isEqualToString:@"platform_info"]) {
            NSDictionary *temPLDic = (NSDictionary *)temDic[str];
            NSDictionary *parPLDic = (NSDictionary *)par[str];
            if(temPLDic.allKeys.count != parPLDic.allKeys.count){
                ischange = YES;
                break;
            }else{
                for (NSString *keys in parPLDic.allKeys) {
                    if (![temPLDic.allKeys containsObject:keys]) {
                        ischange = YES;
                        break;
                    }
                }
            }
        }else
        if (![temDic[str] isEqual:par[str]]) {
            ischange = YES;
            break;
        }
    }
    
    if (!ischange) {
     
        [self.navigationController popViewControllerAnimated:YES];

    }else{
        NSString *message ;
        NSString *okBtn;
        NSString *cancelBtn;
        NSError* err = nil;
        PersonnalModel *model = [[PersonnalModel alloc]initWithDictionary:DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
        if ([model.glamorous integerValue] ==0) {
            message = @"现在退出将榜上无名哟！";
            cancelBtn = @"继续上榜";
            okBtn = @"狠心拒绝";
        }else{
            message = @"你辛苦填写的资料，还没有保存，确定退出吗？";
            okBtn = @"确定";
            cancelBtn = @"取消";
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:okBtn style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:cancelBtn style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}


///选择平台
-(void)choosePla:(SeleBtn *)sender{
    if (!sender.selected && plasCell.seleArr.count == 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"最多选择三个平台"
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender addSubview:sender.topImage];
    }else{
        [sender.topImage removeFromSuperview];
    }

    if (sender.selected) {
        [plasCell.seleArr addObject:sender.titleLabel.text];
    }else{
        [plasCell.seleArr removeObject:sender.titleLabel.text];

    }
    [ThirdCell refreaUIWithPlsArr:plasCell.seleArr];
    //局部cell刷新
    [_moreInfoTab reloadData];

    
}
///擅长领域
-(void)chooseMoreBeGood:(SeleBtn *)btn{
    if (!btn.selected && beGoodCell.seleArr.count == 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"最多选择三个擅长领域"
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn addSubview:btn.topImage];
    }else{
        [btn.topImage removeFromSuperview];
    }
    
    if (btn.selected) {
        [beGoodCell.seleArr addObject:btn.titleLabel.text];
    }else{
        [beGoodCell.seleArr removeObject:btn.titleLabel.text];
        
    }
    
    NSLog(@"%@",beGoodCell.seleArr);
    
}
///选择收入
-(void)chooseIncome:(SeleBtn *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender addSubview:sender.topImage];
    }else{
        [sender.topImage removeFromSuperview];
    }
    if (sender.selected) {
        [incomeCell.seleArr addObject:sender.titleLabel.text];
    }else{
        [incomeCell.seleArr removeObject:sender.titleLabel.text];
        
    }
    
    NSLog(@"%@",incomeCell.seleArr);
}

///选择商业
-(void)chooseBus:(SeleBtn *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender addSubview:sender.topImage];
    }else{
        [sender.topImage removeFromSuperview];
    }
    if (sender.selected) {
        [busCell.seleArr addObject:sender.titleLabel.text];
    }else{
        [busCell.seleArr removeObject:sender.titleLabel.text];
        
    }
    [_moreInfoTab reloadData];
    NSLog(@"%@",busCell.seleArr);
}
#pragma mark textfieleDelegeta
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([busCell.seleArr containsObject:textField.text]) {
        //        包含
        [busCell.seleArr removeObject:textField.text];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length==0) {
        
    }else{
        [busCell.seleArr addObject:textField.text];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
        return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"最多4个字符"
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
    
}
-(void)descriptionIncom{
    
    
    AlertSheet *typesheet = [[AlertSheet alloc] initWithFrame:self.tabBarController.view.bounds];
    [typesheet makeUIWithTitle: @"电商合作－产品推广\n软文视频－节目冠名\n商业代言－肖像使用\n演出经纪－落地活动"];
//      [typesheet makeUIWithTitle: @"商务合作－产品推广软文视频－节目冠名商业代言－肖像使用演出经纪－落地活动"];
    typesheet.lable.contentMode = NSTextAlignmentRight;
    [self.tabBarController.view addSubview:typesheet];

}
@end
