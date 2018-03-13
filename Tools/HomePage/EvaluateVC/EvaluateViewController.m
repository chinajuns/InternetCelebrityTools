//
//  EvaluateViewController.m
//  网红评估工具
//
//  Created by More on 16/9/30.
//  Copyright © 2016年 More. All rights reserved.
//

#import "EvaluateViewController.h"
#import "PerInfoHeaderCell.h"
#import "NickNameTableViewCell.h"
#import "SexTableViewCell.h"
#import "PersonalViewController.h"
#import "CustomTableViewCell.h"
#import "ASBirthSelectSheet.h"
#import "WMZCityChooseSheet.h"
#import "SizeTableViewCell.h"
#import "WMZChooseSheet.h"
//#import "EVAFooterTableViewCell.h"
#import "WMZHeightActionSheet.h"
#import "PersonalViewController.h"
#import "HomeNet.h"
#import "UIButton+WebCache.h"
#import "EvaluateNet.h"
#import "CustomHeadImageVC.h"
@interface EvaluateViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>{
    
//    UIImageView *navBarHairlineImageView;;
    NickNameTableViewCell *nickCell;
    PerInfoHeaderCell *header;
    CustomTableViewCell *birsthdayCell;
    CustomTableViewCell *heightCell;
    CustomTableViewCell *weightCell;
    CustomTableViewCell *cityCell;


    
    SizeTableViewCell  *sizeCell;
    SexTableViewCell  *sexCell;
    PersonnalModel *dataModel;
    
    NSString *city;
    NSArray *cityarr;

    NSMutableDictionary *par;
}
@property (weak, nonatomic) IBOutlet UITableView *evaTabView;
@property (weak, nonatomic) IBOutlet UIButton *dirBtn;

@end

@implementation EvaluateViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.navigationController.navigationBar.hidden = NO;
//    navBarHairlineImageView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
   
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:[PersonalViewController class]]) {
        self.title = @"个人资料";
    }else{
        self.title = @"我的评测";
    }
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    NSError *err;
    dataModel = [[PersonnalModel alloc]initWithDictionary: DEF_PERSISTENT_GET_OBJECT(@"peronInfoDetail") error:&err];
    
    par = [NSMutableDictionary dictionaryWithDictionary:@{
            @"head":dataModel.head,//头像
            @"nickname":dataModel.nickname,//昵称
            @"birthday":[NSString stringWithFormat:@"%ld",(long)dataModel.birthday ] ,//生日 转成时间戳
            @"sex":dataModel.sex,//性别，女1男2
            @"bust":dataModel.bust,//胸围
            @"waistline":dataModel.waistline,//腰围
            @"hipline":dataModel.hipline,//臀围
            @"height":dataModel.height,//身高
            @"weight":dataModel.weight,//体重
            @"live_province":dataModel.live_province,
            @"live_city":dataModel.live_city
            }];

    
   
    

    [_evaTabView registerNib:[UINib nibWithNibName:@"PerInfoHeaderCell" bundle:nil] forCellReuseIdentifier:@"header"];
    [_evaTabView registerNib:[UINib nibWithNibName:@"NickNameTableViewCell" bundle:nil] forCellReuseIdentifier:@"NickName"];
    [_evaTabView registerNib:[UINib nibWithNibName:@"SexTableViewCell" bundle:nil] forCellReuseIdentifier:@"SEXCell"];
    [_evaTabView registerNib:[UINib nibWithNibName:@"FirstStupCell" bundle:nil] forCellReuseIdentifier:@"FirstCell"];
    [_evaTabView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"customCell"];
    [_evaTabView registerNib:[UINib nibWithNibName:@"SizeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SizeCell"];
    [_evaTabView registerNib:[UINib nibWithNibName:@"EVAFooterTableViewCell" bundle:nil] forCellReuseIdentifier:@"EVAfooterCell"];

    _evaTabView.delegate =self;
    _evaTabView.dataSource=self;
    
    header  =  [_evaTabView dequeueReusableCellWithIdentifier:@"header"];
    [header.headerImageBtn sd_setImageWithURL:[NSURL URLWithString:dataModel.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logopl"]];
    [header.headerImageBtn addTarget:self action:@selector(chooseHeadr) forControlEvents:UIControlEventTouchUpInside];
    header.backgroundColor = [UIColor clearColor];
    
  
    
    
    birsthdayCell = [_evaTabView dequeueReusableCellWithIdentifier:@"customCell"];
    birsthdayCell.titleLable.text= @"生日";

    NSString *bir = [self formateDateNum:dataModel.birthday withFormateStr:@"yyyy-MM-dd"];
    if ([bir isEqualToString:@"1970-01-01"]) {
        [birsthdayCell.typeBtn setImage:[UIImage imageNamed:@"7-拷贝-2"] forState:UIControlStateNormal];

    }else{
        [birsthdayCell.typeBtn setImage:nil forState:UIControlStateNormal];

        [birsthdayCell.typeBtn setTitle:bir  forState:UIControlStateNormal];

    }
    
    [birsthdayCell.typeBtn addTarget:self action:@selector(chooseBirthday) forControlEvents:UIControlEventTouchUpInside];
    [birsthdayCell.isMustImage setImage:[UIImage imageNamed:@"个人信息-生日"]];
    birsthdayCell.backgroundColor = [UIColor clearColor];
//    [birsthdayCell.typeBtn setImage:[UIImage imageNamed:@"7-拷贝-2"] forState:UIControlStateNormal];

    sizeCell  = [_evaTabView dequeueReusableCellWithIdentifier:@"SizeCell"];
    sizeCell.isShow =NO;
    sizeCell.moreView.hidden= YES;
    [sizeCell.braSizeBtn addTarget:self action:@selector(chooseBra) forControlEvents:UIControlEventTouchUpInside];
    [sizeCell.waistSizeBtn addTarget:self action:@selector(chooseWaist) forControlEvents:UIControlEventTouchUpInside];
    [sizeCell.hipsSizeBtn addTarget:self action:@selector(chooseHips) forControlEvents:UIControlEventTouchUpInside];
    sizeCell.backgroundColor = [UIColor clearColor];

    
    heightCell = [_evaTabView dequeueReusableCellWithIdentifier:@"customCell"];
    heightCell.titleLable.text= @"身高(cm)";
    if ([dataModel.height integerValue] ==0 ) {
        [heightCell.typeBtn setImage:[UIImage imageNamed:@"7-拷贝-2"] forState:UIControlStateNormal];

    }else{
        [heightCell.typeBtn setTitle:dataModel.height forState:UIControlStateNormal ];
        [heightCell.typeBtn setImage:nil forState:UIControlStateNormal];

    }
    [heightCell.isMustImage setImage:[UIImage imageNamed:@"量尺"]];


    [heightCell.typeBtn addTarget:self action:@selector(chooseHeight) forControlEvents:UIControlEventTouchUpInside];
    heightCell.backgroundColor =[UIColor clearColor];
    
    weightCell = [_evaTabView dequeueReusableCellWithIdentifier:@"customCell"];
    weightCell.titleLable.text= @"体重(kg)";
    if([dataModel.height integerValue] ==0  ) {
        [weightCell.typeBtn setImage:[UIImage imageNamed:@"7-拷贝-2"] forState:UIControlStateNormal];


    }else{
        
        [weightCell.typeBtn setTitle:dataModel.weight forState:UIControlStateNormal ];
        [weightCell.typeBtn setImage:nil forState:UIControlStateNormal];
    }

    
    city  = @"北京市东城区";
    cityCell=[_evaTabView dequeueReusableCellWithIdentifier:@"customCell"];
    cityCell.titleLable.text = @"城市";
    cityCell.backgroundColor = [UIColor clearColor];
    if (dataModel.live_province.length>0) {
        [cityCell.typeBtn setTitle:[NSString stringWithFormat:@"%@%@",dataModel.live_province,dataModel.live_city] forState:UIControlStateNormal];
        cityarr = @[dataModel.live_province,dataModel.live_city];
        
    }else{
        [cityCell.typeBtn setTitle:@"请选择城市" forState:UIControlStateNormal];
   
    }
    [cityCell.typeBtn addTarget:self action:@selector(cityChooseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [cityCell.typeBtn setImage:nil forState:UIControlStateNormal];

    
    
    [weightCell.typeBtn addTarget:self action:@selector(chooseWeight) forControlEvents:UIControlEventTouchUpInside];
    weightCell.backgroundColor  =[UIColor clearColor];
    [weightCell.isMustImage setImage:[UIImage imageNamed:@"足迹"]];

    sexCell =  [_evaTabView dequeueReusableCellWithIdentifier:@"SEXCell"];
    [sexCell.manBtn addTarget:self action:@selector(manBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [sexCell.womenBtn addTarget:self action:@selector(womenBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    

    sizeCell =  [_evaTabView dequeueReusableCellWithIdentifier:@"SizeCell"];
    if ([dataModel.sex integerValue]==1) {
        
        if (sexCell. womenBtn.selected==NO) {
            sexCell.womenBtn.selected= YES;
            sexCell.manBtn.selected = NO;
            sexCell.sexStr = @"女";
            
            [sizeCell.hipsSizeBtn setTitle:@"请选择" forState:UIControlStateNormal];
            sizeCell.hipsSizeBtn.userInteractionEnabled = YES;
            
            [sizeCell.braSizeBtn setTitle:@"请选择" forState:UIControlStateNormal];
            sizeCell.braSizeBtn.userInteractionEnabled = YES;
            
            [sizeCell.waistSizeBtn setTitle:@"请选择" forState:UIControlStateNormal];
            sizeCell.waistSizeBtn.userInteractionEnabled = YES;
            [par setObject:@"1" forKey:@"sex"];
            
        }
        
        if ([dataModel.bust integerValue]!=0) {
            [sizeCell.braSizeBtn setTitle:dataModel.bust forState:UIControlStateNormal];
        }
        if ([dataModel.waistline integerValue]!=0) {
            [sizeCell.waistSizeBtn setTitle:dataModel.waistline forState:UIControlStateNormal];
        }
        if ([dataModel.hipline integerValue]!=0) {
            [sizeCell.hipsSizeBtn setTitle:dataModel.hipline forState:UIControlStateNormal];
        }
    }else{
        if (sexCell.manBtn.selected==NO) {
            sexCell.manBtn.selected= YES;
            sexCell.womenBtn.selected = NO;
            sexCell.sexStr= @"男";
            [sizeCell.hipsSizeBtn setTitle:@"不填" forState:UIControlStateNormal];
            sizeCell.hipsSizeBtn.userInteractionEnabled = NO;
            
            [sizeCell.braSizeBtn setTitle:@"不填" forState:UIControlStateNormal];
            sizeCell.braSizeBtn.userInteractionEnabled = NO;
            
            [sizeCell.waistSizeBtn setTitle:@"不填" forState:UIControlStateNormal];
            sizeCell.waistSizeBtn.userInteractionEnabled = NO;
            [par setObject:@"2" forKey:@"sex"];
            
            
        }
    }

    
   nickCell  = [_evaTabView dequeueReusableCellWithIdentifier:@"NickName"];
    nickCell.nameTextfield.text = dataModel.nickname;
    nickCell.nameTextfield.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [MobClick event:@"evaluateBack"];

    [par setObject:nickCell.nameTextfield.text forKey:@"nickname"];

    if ([self isChange]) {
        
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

        }else{
        [self.navigationController popViewControllerAnimated:YES];

    }
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
//        case 0:{
//            
//       
//            FirstStupCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];;;
//            for (UIView *view in cell.subviews) {
//                view.hidden = YES;
//            }
//            return cell;
//            break;
//        }
        case 0:
            
            return  header;
            break;
        case 1:{
            
            nickCell.backgroundColor = [UIColor clearColor];
            
            return  nickCell;
            break;}
        case 2:
        {
         
            sexCell.backgroundColor = [UIColor clearColor];
            
            return sexCell;
            break;
        }
        case 3:
            return birsthdayCell;
            break;
        case 4:
            
        {
            [sizeCell.hipsSizeBtn addTarget:self action:@selector(chooseHips) forControlEvents:UIControlEventTouchUpInside];
            [sizeCell.waistSizeBtn addTarget:self action:@selector(chooseWaist) forControlEvents:UIControlEventTouchUpInside];
            [sizeCell.braSizeBtn addTarget:self action:@selector(chooseBra) forControlEvents:UIControlEventTouchUpInside];
            if ([par[@"sex"] isEqualToString:@"1"]) {
                for (UIView *view in sizeCell.subviews) {
                    view.hidden = NO;
                }
                
            }else{
                for (UIView *view in sizeCell.subviews) {
                    view.hidden = YES;
                }
            }
            return sizeCell;
            break;
        }
       
        case 5:
        {
            return heightCell;
            break;
        }
        case 6:
        {
            return weightCell;
            break;
        }
        case 7:
            return cityCell;
            break;
  
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
            return SCREEN_WIDTH/3+50;
            break;
        
        case 4:
            if ([par[@"sex"] isEqualToString:@"1"]) {
                return 130;

            }else{
                return 0;
            }
            break;
        default:
            return 60.0f;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
- (IBAction)scroTopBottom:(id)sender {
        if (_evaTabView.contentSize.height > _evaTabView.frame.size.height)
        {
            CGPoint offset = CGPointMake(0, _evaTabView.contentSize.height - _evaTabView.frame.size.height);
            [_evaTabView setContentOffset:offset animated:NO];
        }

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    CGFloat maximumOffset = size.height;
    if(maximumOffset - currentOffset<60){
        _dirBtn.hidden = YES;
    
    }else{
        _dirBtn.hidden=NO;
    }
}
-(BOOL)isChange{
   
    if (![par[@"nickname"] isEqualToString:dataModel.nickname]) {
        return true;
    }
    
    if (![par[@"birthday"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)dataModel.birthday ]]) {
        return true;
    }
    if (![par[@"sex"] isEqualToString:dataModel.sex]) {
        return true;

    }
    if (![par[@"bust"] isEqualToString:dataModel.bust]) {
        return true;

    }
    if (![par[@"waistline"] isEqualToString:dataModel.waistline]) {
        return true;

    }
    if (![par[@"hipline"] isEqualToString:dataModel.hipline]) {
        return true;

    }
    if (![par[@"height"] isEqualToString:dataModel.height]) {
        return true;

    }
    if (![par[@"weight"] isEqualToString:dataModel.weight]) {
        return true;
    }
    if (![par[@"live_province"] isEqualToString:dataModel.live_province]) {
        return true;
    }
    if (![par[@"live_city"] isEqualToString:dataModel.live_city]) {
        return true;
    }

    return false;
}
- (IBAction)nextStep:(id)sender {
    
    
    if (nickCell.nameTextfield.text.length==0) {
        [nickCell.nameTextfield becomeFirstResponder];
        return;
    }
    [MobClick event:@"evaluateNext"];

    [par setObject:nickCell.nameTextfield.text forKey:@"nickname"];
    
    
    if (!par[@"birthday"] || [par[@"birthday"] integerValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善生日信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (!par[@"height"] || [par[@"height"] integerValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善身高信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    

    
    if (!par[@"weight"] || [par[@"weight"] integerValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善体重信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if(par[@"live_city"]){
        
        if (!par[@"live_city"] || ((NSString *)par[@"live_city"]) .length==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善居住城市信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善居住城市信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ( [par[@"sex"] integerValue]==1) {
        if (!par[@"waistline"] || [par[@"waistline"] integerValue]==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善腰围信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        if (!par[@"bust"] || [par[@"bust"] integerValue]==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善胸围信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        if (!par[@"hipline"] || [par[@"hipline"] integerValue]==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善臀围信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        
    }
    
 
    
    
//    if ([par[@"birthday"] integerValue]==0
//        || [par[@"height"] integerValue]==0
//        ||[par[@"weight"] integerValue]==0
//        || [par[@"live_city"] stringValue].length==0
//        ||[par[@"live_province"] stringValue].length==0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善个人信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//        [alert show];
//        return;
//    }else{
//        if ([par[@"sex"] integerValue]==1) {
//            [par setObject:nickCell.nameTextfield.text forKey:@"nickname"];
//            if ([par[@"waistline"] integerValue]==0
//                || [par[@"bust"] integerValue]==0
//                ||[par[@"hipline"] integerValue]==0){
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"完善个人信息，有助于提升您的排名喔" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//                [alert show];
//            }
//            return;
//        }
//    }
//    

    
    if ([self isChange]) {
        [SVProgressHUD show];
        [EvaluateNet submitPerinfo:par Success:^(NSArray *date) {
            [self reSteModel];
            [self performSegueWithIdentifier:@"gotomoreinfo" sender:self];
            [SVProgressHUD showWithStatus:@"保存成功"];
            [SVProgressHUD dismissWithDelay:1];
            
        }];

    }else{
        [self reSteModel];

        [self performSegueWithIdentifier:@"gotomoreinfo" sender:self];

    }
    
    

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
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"图片上传中"];

    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [BaseNetWork upLoadWithImage:newPhoto preGress:^(CGFloat progress) {
        NSLog(@"%lf",progress);
    } success:^(NSDictionary *result) {

            [SVProgressHUD showWithStatus:@"图片上传成功"];
            [SVProgressHUD dismissWithDelay:1];

    }];
    [header.headerImageBtn setImage:newPhoto forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark choose birthday
-(void)chooseBirthday{
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        [birsthdayCell.typeBtn setTitle:dateStr forState:UIControlStateNormal];
        [birsthdayCell.typeBtn setImage:nil forState:UIControlStateNormal];
        [par setObject:[self ageWithDateOfBirth:dateStr] forKey:@"birthday"];
    };
    [self.view addSubview:datesheet];

    
}

-(void)chooseHeight{
   

    
    WMZHeightActionSheet *typesheet = [[WMZHeightActionSheet alloc] initWithFrame:self.view.bounds];
    typesheet.titleStr = @"身高(cm)";
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
        if (Result) {
            [heightCell.typeBtn setTitle:[NSString stringWithFormat:@"%@", Result] forState:UIControlStateNormal];
            [heightCell.typeBtn setImage:nil forState:UIControlStateNormal];
            [par setObject:Result forKey:@"height"];
        }
      

        
    };
    [self.view addSubview:typesheet];
}
-(void)chooseWeight{
    

    
    WMZHeightActionSheet *typesheet = [[WMZHeightActionSheet alloc] initWithFrame:self.view.bounds];
    typesheet.titleStr = @"体重(kg)";
    [typesheet makeUI];

    typesheet.GetSelectStr = ^(NSString *Result) {
        if (Result) {
            [weightCell.typeBtn setTitle:[NSString stringWithFormat:@"%@", Result] forState:UIControlStateNormal];
            [weightCell.typeBtn setImage:nil forState:UIControlStateNormal];
            [par setObject:Result forKey:@"weight"];
        }
        

    };
    [self.view addSubview:typesheet];
}
-(void)chooseBra{
    if ([sexCell.sexStr isEqualToString:@"男"]) {
        return;
    }
    WMZChooseSheet *typesheet = [[WMZChooseSheet alloc] initWithFrame:self.view.bounds];
    NSArray *height =@[@"70A",@"70B",@"70C",@"70D",@"75A",@"75B",@"75C",@"75D",@"75E",@"80A",@"80B",@"80C",@"80D",@"80E",@"90B",@"90C",@"90D",@"90E"];
    typesheet.titleStr=@"胸围";

    typesheet.dataSoure = height;
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
       [ sizeCell.braSizeBtn setTitle:Result forState:UIControlStateNormal];
        [par setObject:Result forKey:@"bust"];
        

    };
    [self.view addSubview:typesheet];

}
-(void)chooseWaist{
    if ([sexCell.sexStr isEqualToString:@"男"]) {
        return;
    }

    WMZChooseSheet *typesheet = [[WMZChooseSheet alloc] initWithFrame:self.view.bounds];
    NSArray *height =@[@"66及以下",@"67-69",@"70-72",@"73-75",@"76-78",@"79-81",@"82- 84",@"85-87",@"88-91",@"92-94",@"95-97",@"98及以上"];
    typesheet.titleStr=@"腰围";

    typesheet.dataSoure = height;
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
        [ sizeCell.waistSizeBtn setTitle:Result forState:UIControlStateNormal];
        [par setObject:Result forKey:@"waistline"];


    };
    [self.view addSubview:typesheet];
  


}
-(void)chooseHips{
    if ([sexCell.sexStr isEqualToString:@"男"]) {
        return;
    }
    WMZChooseSheet *typesheet = [[WMZChooseSheet alloc] initWithFrame:self.view.bounds];
    NSArray *hips =@[@"66及以下",@"67-69",@"70-72",@"73-75",@"76-78",@"79-81",@"82- 84",@"85-87",@"88-91",@"92-94",@"95-97",@"98及以上"];
    typesheet.titleStr=@"臀围";
    typesheet.dataSoure = hips;
    [typesheet makeUI];
    typesheet.GetSelectStr = ^(NSString *Result) {
        [ sizeCell.hipsSizeBtn setTitle:Result forState:UIControlStateNormal];
        [par setObject:Result forKey:@"hipline"];

    };
    [self.view addSubview:typesheet];
    
    
}
#pragma mark cityChooseDelegate

-(void)cityChooseBtnPressed{
    WMZCityChooseSheet *datesheet = [[WMZCityChooseSheet alloc] initWithFrame:self.view.bounds];
    datesheet.GetSelectCity = ^(NSString *chooseCity) {
        NSLog(@"%@",chooseCity);
        [cityCell.typeBtn setTitle:chooseCity forState:UIControlStateNormal];
        cityarr = [chooseCity componentsSeparatedByString:@" "];
        [par setObject:cityarr[0] forKey:@"live_province"];
        [par setObject:cityarr[1] forKey:@"live_city"];
        
        
    };
    [self.view addSubview:datesheet];
    
}

- (void)womenBtnPressed:(id)sender {
    if (sexCell. womenBtn.selected==NO) {
        sexCell.womenBtn.selected= YES;
        sexCell.manBtn.selected = NO;
        sexCell.sexStr = @"女";
        
        [sizeCell.hipsSizeBtn setTitle:@"请选择" forState:UIControlStateNormal];
        sizeCell.hipsSizeBtn.userInteractionEnabled = YES;
        
        [sizeCell.braSizeBtn setTitle:@"请选择" forState:UIControlStateNormal];
        sizeCell.braSizeBtn.userInteractionEnabled = YES;
        
        [sizeCell.waistSizeBtn setTitle:@"请选择" forState:UIControlStateNormal];
        sizeCell.waistSizeBtn.userInteractionEnabled = YES;
        [par setObject:@"1" forKey:@"sex"];
        [_evaTabView reloadData];

    }
}
- (void)manBtnPressed:(id)sender {
    if (sexCell.manBtn.selected==NO) {
        sexCell.manBtn.selected= YES;
        sexCell.womenBtn.selected = NO;
        sexCell.sexStr= @"男";
        [sizeCell.hipsSizeBtn setTitle:@"不填" forState:UIControlStateNormal];
        sizeCell.hipsSizeBtn.userInteractionEnabled = NO;
        
        [sizeCell.braSizeBtn setTitle:@"不填" forState:UIControlStateNormal];
        sizeCell.braSizeBtn.userInteractionEnabled = NO;
        
        [sizeCell.waistSizeBtn setTitle:@"不填" forState:UIControlStateNormal];
        sizeCell.waistSizeBtn.userInteractionEnabled = NO;
        [par setObject:@"2" forKey:@"sex"];
        [_evaTabView reloadData];

     
    }
}

-(NSString *)formateDateNum:(NSInteger) dateNum withFormateStr:(NSString *)formatstr
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:formatstr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/chongqing"];
    [formater setTimeZone:timeZone];
    NSString *dateStr = [formater stringFromDate:date];
    
   
    return dateStr;
}
- (NSString *)ageWithDateOfBirth:(NSString *)bir;
{
    //    NSString *string = @"2016-7-16 09:33:22";
    
    // 日期格式化类
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    
    format.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    
    NSDate *date = [format dateFromString:bir];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
    
}

-(void)reSteModel{
//    dataModel.head = par[@"head"];
    dataModel.nickname = par[@"nickname"];
    dataModel.birthday = [par[@"birthday"]  integerValue]; ;
    dataModel.sex = par[@"sex"];
    dataModel.bust = par[@"bust"];
    dataModel.hipline =par[@"hipline"];
    dataModel.waistline = par[@"waistline"];
    dataModel.height = par[@"height"];
    dataModel.weight = par[@"weight"];
    if (cityarr) {
        dataModel.live_province = cityarr[0];
        dataModel.live_city = cityarr[1];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length == 0) return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 11) {
        return NO;
    }
    
    return YES;
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
