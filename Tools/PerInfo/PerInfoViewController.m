//
//  PerInfoViewController.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "PerInfoViewController.h"
#import "MoreHotCell.h"
#import "PerInfoHeaderCell.h"
#import "NickNameTableViewCell.h"
#import "SexTableViewCell.h"
#import "CustomTableViewCell.h"
#import "WMZCityChooseSheet.h"
#import "WMZChooseSheet.h"
#import "MoreHotRecomVC.h"
#import "UIButton+WebCache.h"
#import "CustomHeadImageVC.h"
@interface PerInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    NickNameTableViewCell  *nickNmaeCell;
    PerInfoHeaderCell *header;
    CustomTableViewCell *cityCell;
    CustomTableViewCell *typeCell;
    CustomTableViewCell *shopTypeCell;
    
    SexTableViewCell *sexCell;

    NSString *city;
    
    
    NSArray *shopType;
    NSString *shopTypeString;
    
    
    NSArray *hotType;
    int flag ;///1 红人 2 商家

    NSMutableDictionary *par;
    
    
    BOOL  imageFlag;
}
@property (weak, nonatomic) IBOutlet UITableView *infoTab;
@property (strong, nonatomic)  UIPickerView *pickerView;
@property (nonatomic,strong)NSArray * provinces;//展示省份
@property (nonatomic,strong)NSArray * cities;//展示城市
@end

@implementation PerInfoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.navigationController.navigationBar.hidden = NO;

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imageFlag = NO;
    par = [[NSMutableDictionary alloc]initWithDictionary:@{
                                                          @"nickname":@"",
                                                          @"sex":@"1",
                                                          @"live_province":@"",
                                                          @"live_city":@"",
                                                          @"user_type":@"1",
                                                          @"business_type":@"",
                                                           }];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
 
    
    
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    self.title  = @"完善个人资料";
    
    flag=1;
    _infoTab.delegate =self;
    _infoTab.dataSource= self;
    _infoTab.bounces = NO;
    
    [_infoTab registerNib:[UINib nibWithNibName:@"PerInfoHeaderCell" bundle:nil] forCellReuseIdentifier:@"header"];
    [_infoTab registerNib:[UINib nibWithNibName:@"NickNameTableViewCell" bundle:nil] forCellReuseIdentifier:@"NickName"];
    [_infoTab registerNib:[UINib nibWithNibName:@"SexTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEXCell"];
    [_infoTab registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"customCell"];

    header  =  [_infoTab dequeueReusableCellWithIdentifier:@"header"];
    header.backgroundColor = [UIColor clearColor];
    [header.headerImageBtn addTarget:self action:@selector(chooseHeadr) forControlEvents:UIControlEventTouchUpInside];
    
    city  = @"北京市东城区";
    shopTypeString=@"IT/通信／互联网";
    cityCell=[_infoTab dequeueReusableCellWithIdentifier:@"customCell"];
    cityCell.titleLable.text = @"城市";
    cityCell.backgroundColor = [UIColor clearColor];
    [cityCell.typeBtn setTitle:@"请选择城市" forState:UIControlStateNormal];
    [cityCell.typeBtn addTarget:self action:@selector(cityChooseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [cityCell.typeBtn setImage:nil forState:UIControlStateNormal];

    typeCell=[_infoTab dequeueReusableCellWithIdentifier:@"customCell"];
    
    typeCell.titleLable.text = @"我是";
    typeCell.isMustImage.hidden= YES;
    typeCell.backgroundColor = [UIColor clearColor];
    [typeCell.typeBtn setImage:nil forState:UIControlStateNormal];
    [typeCell.typeBtn  setTitle:@"红人" forState:UIControlStateNormal];
    [typeCell.typeBtn addTarget:self action:@selector(perTypeChoose) forControlEvents:UIControlEventTouchUpInside];
    
    shopTypeCell=[_infoTab dequeueReusableCellWithIdentifier:@"customCell"];
    shopTypeCell.titleLable.text=@"红人类型";
    shopTypeCell.backgroundColor = [UIColor clearColor];
    shopTypeCell.isMustImage.hidden= YES;
    [shopTypeCell.typeBtn setImage:nil forState:UIControlStateNormal];
    [shopTypeCell.typeBtn  setTitle:@"美容／时尚" forState:UIControlStateNormal];
    [shopTypeCell.typeBtn addTarget:self action:@selector(perTypeChooseBtnPressed) forControlEvents:UIControlEventTouchUpInside];

    
    shopType = @[@"IT/通信／互联网",@"金融行业",@"房地产／建筑",@"商业服务",@"贸易类",@"文体教育／工艺美术",@"生产／加工／制造行业",@"交投运输物流行业",@"服务业",@"文化传媒行业",@"非赢利机构"];
    hotType = @[@"时尚/美容",@"美食",@"搞笑段子",@"娱乐",@"明星",@"游戏",@"母婴",@"健康",@"宠物",@"科技",@"财经",@"旅游",@"生活",@"其他"];
    sexCell =  [_infoTab dequeueReusableCellWithIdentifier:@"SEXCell"];
    
    nickNmaeCell =  [_infoTab dequeueReusableCellWithIdentifier:@"NickName"];
    nickNmaeCell.backgroundColor = [UIColor clearColor];
    sexCell.sexStr = @"女";
    [par setObject:@"1" forKey:@"sex"];
    
    if (_userinfo) {
//        [par setObject:_userinfo.iconurl forKey:@"head"];
        nickNmaeCell.nameTextfield.text = _userinfo.name;
        
        [header.headerImageBtn sd_setImageWithURL:[NSURL URLWithString:_userinfo.iconurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"相机.png"]];
        [SVProgressHUD show];
        [BaseNetWork upLoadWithImage:header.headerImageBtn.imageView.image preGress:^(CGFloat progress) {
            [SVProgressHUD showWithStatus:@"保存成功"];
            [SVProgressHUD dismissWithDelay:1];
            
        } success:^(NSDictionary *result) {
            [SVProgressHUD dismiss];
            
            //        NSLog(@"%@",result);
            //        [par setObject:result forKey:@"head"];
        }];

        
   

        if ([_userinfo.gender isEqualToString:@"男"]||[_userinfo.gender isEqualToString:@"f"]) {
            if (sexCell. womenBtn.selected==NO) {
                sexCell.womenBtn.selected= YES;
                sexCell.manBtn.selected = NO;
                sexCell.sexStr = @"女";
                [par setObject:@"1" forKey:@"sex"];
                
            }
        
        }else{
            if (sexCell.manBtn.selected==NO) {
                sexCell.manBtn.selected= YES;
                sexCell.womenBtn.selected = NO;
                sexCell.sexStr= @"男";
                [par setObject:@"2" forKey:@"sex"];
                
                
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(flag == 1 ){
        return 5;
    }
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    switch (indexPath.row) {
        case 0:
            return header;
            break;
        case 1:{
            return nickNmaeCell;
            break;
        }
        case 2:{
            [sexCell.manBtn addTarget:self action:@selector(manBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [sexCell.womenBtn addTarget:self action:@selector(womenBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            sexCell.backgroundColor = [UIColor clearColor];
            return sexCell;
            break;
        }
        case 3:
            return cityCell;
            break;
        case 4:
            return typeCell;
            break;
        case 5:{
            if (flag==1) {
             

            }else{
                return shopTypeCell;
                break;
            }
        }
            
 
       
        default:
            return nil;
            break;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    switch (indexPath.row) {
        case 0:
            return 200;
            break;
     
        default:
            return 60.0f;

            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (IBAction)nextBtnPressed:(id)sender {
    
    if (nickNmaeCell.nameTextfield.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"昵称不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    if ([[par objectForKey:@"live_province"] isEqualToString:@""]) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择居住城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    if (!imageFlag) {
        if ([sexCell.sexStr isEqualToString:@"女"]) {
            [par setObject:[NSString stringWithFormat:@"http://apihot.moreyoung.cc/uploads/head/img/1_%d.png",arc4random()%6+1] forKey:@"head"];
        }else{
               [par setObject:[NSString stringWithFormat:@"http://apihot.moreyoung.cc/uploads/head/img/2_%d.png",arc4random()%6+1] forKey:@"head"];
        }

    }
    [par setObject:nickNmaeCell.nameTextfield.text forKey:@"nickname"];
    [SVProgressHUD show];

    [self postdataWithString:@"member/setprofile" parameters:par scuccessBlock:^(NSDictionary *result) {
        [self performSegueWithIdentifier:@"gotoPushList" sender:self];
        [SVProgressHUD dismiss];
    }];

    
}

-(void)postdataWithString:(NSString *)urlString parameters:(NSDictionary*)parameters   scuccessBlock:(void(^)(NSDictionary* result))successBlock{
    
    
    if ([DEF_PERSISTENT_GET_OBJECT(@"NET") integerValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到网络，请检查网络连接" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [SVProgressHUD dismiss];
        return ;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [NSString stringWithFormat:@"%@%@",BaseUrl,urlString];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@&deviceid=%@&token=%@",BaseUrl,urlString,DEF_PERSISTENT_GET_OBJECT(@"Token"),  DEF_PERSISTENT_GET_OBJECT(@"LoginToken") ] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);  //这里打印错误信息
        [SVProgressHUD showErrorWithStatus:@"网络错误，请稍后再试"];
        [SVProgressHUD dismissWithDelay:1];
        
    }];
}

#pragma changeHeader
- (void)chooseHeadr {
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];

    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    imageFlag=YES;
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [SVProgressHUD show];
    [BaseNetWork upLoadWithImage:newPhoto preGress:^(CGFloat progress) {
     
        NSLog(@"%lf",progress);

        
    } success:^(NSDictionary *result) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showWithStatus:@"保存成功"];
        [SVProgressHUD dismissWithDelay:1];
    }];
    [header.headerImageBtn setImage:newPhoto forState:UIControlStateNormal];

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark cityChooseDelegate

-(void)cityChooseBtnPressed{
        WMZCityChooseSheet *datesheet = [[WMZCityChooseSheet alloc] initWithFrame:self.view.bounds];
        datesheet.GetSelectCity = ^(NSString *chooseCity) {
            NSLog(@"%@",chooseCity);
                [cityCell.typeBtn setTitle:chooseCity forState:UIControlStateNormal];
            NSArray *arr = [chooseCity componentsSeparatedByString:@" "];
            [par setObject:arr[0] forKey:@"live_province"];
            [par setObject:arr[1] forKey:@"live_city"];

            
        };
        [self.view addSubview:datesheet];

}
-(void)perTypeChooseBtnPressed{
    WMZChooseSheet *typesheet = [[WMZChooseSheet alloc] initWithFrame:self.view.bounds];
    if ([typeCell.typeBtn.titleLabel.text isEqualToString:@"红人"]) {
        typesheet.dataSoure = hotType;
        
    }else{
        typesheet.dataSoure = shopType;


    }
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
            [shopTypeCell.typeBtn setTitle:Result forState:UIControlStateNormal];
        [par setObject:Result forKey:@"business_type"];

       
    };
    [self.view addSubview:typesheet];
}


#pragma mart  personalType
-(void)perTypeChoose{
    
    WMZChooseSheet *typesheet = [[WMZChooseSheet alloc] initWithFrame:self.view.bounds];
   
    typesheet.dataSoure = @[@"红人",@"商家"];
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
        if ([Result isEqualToString:@"红人"]) {
            [typeCell.typeBtn setTitle:@"红人" forState:UIControlStateNormal];
            [par setObject:@"1" forKey:@"user_type"];
            [par setObject:@"" forKey:@"business_type"];
            flag=1;
        }else{
            [typeCell.typeBtn setTitle:@"商家" forState:UIControlStateNormal];
            shopTypeCell.titleLable.text=@"商家类型";
            [shopTypeCell.typeBtn  setTitle:@"IT/通信／互联网" forState:UIControlStateNormal];
            [shopTypeCell.typeBtn  setImage:nil  forState:UIControlStateNormal];
            flag=2;
            [par setObject:@"2" forKey:@"user_type"];
            [par setObject:@"T/通信／互联网" forKey:@"business_type"];


        }
        [_infoTab reloadData];
        
    };
    [self.view addSubview:typesheet];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"gotoPushList"])
    {////这里toVc是拉的那条线的标识符
        
        MoreHotRecomVC *theVc = segue.destinationViewController;
        theVc.userType = typeCell.typeBtn.titleLabel.text;
//        theVc.isShowNext = YES;
        theVc.navStr = @"红人墙";
    }
}

- (void)womenBtnPressed:(id)sender {
    if (sexCell. womenBtn.selected==NO) {
        sexCell.womenBtn.selected= YES;
        sexCell.manBtn.selected = NO;
        sexCell.sexStr = @"女";
        [par setObject:@"1" forKey:@"sex"];
   
    }
}
- (void)manBtnPressed:(id)sender {
    if (sexCell.manBtn.selected==NO) {
        sexCell.manBtn.selected= YES;
        sexCell.womenBtn.selected = NO;
        sexCell.sexStr= @"男";
        [par setObject:@"2" forKey:@"sex"];

       
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
