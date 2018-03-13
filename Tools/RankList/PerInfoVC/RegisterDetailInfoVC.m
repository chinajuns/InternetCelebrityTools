//
//  RegisterDetailInfoVC.m
//  钱转转
//
//  Created by More on 16/11/3.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RegisterDetailInfoVC.h"
#import "RegisterDetailCell.h"
#import "RegisterUpdataPhotoCell.h"
#import "PersonalInfoNet.h"
@interface RegisterDetailInfoVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *typeTitleArr;
    NSArray *typeTextPlaArr;
    
    NSMutableDictionary *par;
    
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation RegisterDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    // Do any additional setup after loading the view.
    [self makeUI];
}
-(void)makeData{
    typeTitleArr = @[@"申请人姓名",@"公司名字",@"公司所属行业",@"您的职位",@"商务需求",@"联系方式"];
    typeTextPlaArr  = @[@"请输入你的真实姓名",@"请输入您公司名字",@"请选择您所属的行业",@"请输入您的职位",@"请选择您的需求",@"请输入您的联系方式"];
    par = [[NSMutableDictionary alloc]init];
    [par setObject:_uid forKey:@"uid"];

}
-(void)makeUI{
//    self.title =  @"完善资料";
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    self.view.backgroundColor = [UIColor colorWithHexString:@"383838"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"383838"];

    _tableView.delegate = self;
    _tableView.dataSource  =self;

    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return typeTitleArr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==typeTitleArr.count ) {
        RegisterUpdataPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
        if (!cell) {
            cell  = [[RegisterUpdataPhotoCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoCell"];
        }
        cell.ChooseFirImage= ^(NSString *img){
            [par setObject:img forKey:@"pic1"];
        };
        cell.ChooseSecondImage= ^(NSString *img){
            [par setObject:img forKey:@"pic2"];
        };
        cell.backgroundColor = [UIColor colorWithHexString:@"383838"];
     
        return cell;
    }
    
    RegisterDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
    if (!cell) {
        cell  = [[RegisterDetailCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseCell"];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"383838"];
    cell.typeTextfield.enabled =NO;
    cell.tagStr = typeTitleArr[indexPath.row];
    cell.typeLable.text = typeTitleArr[indexPath.row];
    cell.typeTextfield.placeholder = typeTextPlaArr[indexPath.row];
  
            cell.ChangePar = ^(NSString *str){
                switch (indexPath.row) {
                    case 0:
                        [par setObject:str forKey:@"name"];
                        break;
                    case 1:
                        [par setObject:str forKey:@"company"];
                        break;
                    case 2:
                        [par setObject:str forKey:@"industry"];
                        break;
                    case 3:
                        [par setObject:str forKey:@"job"];
                        break;
                    case 4:
                        [par setObject:str forKey:@"need"];
                        break;
                    case 5:
                        [par setObject:str forKey:@"contact"];
                        break;
                    default:
                        break;
                }
            };
       
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==typeTitleArr.count ) {
        return AdaptedHeightValue(420 + 40);
    }
    return AdaptedHeightValue(120.0);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedHeightValue(16.0);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeightValue(64+90))];
    UIButton *submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    submitBtn.backgroundColor = [UIColor colorWithHexString:@"A33C50"];
    [submitBtn addTarget:self action:@selector(footerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    footer.backgroundColor = [UIColor colorWithHexString:@"383838"];

    [footer addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footer.mas_centerX);
        make.top.mas_equalTo(AdaptedHeightValue(64));
        make.height.mas_equalTo(AdaptedHeightValue(90));
        make.width.mas_equalTo(SCREEN_WIDTH-2*AdaptedWidthValue(20));
        submitBtn.layer.cornerRadius=8;
    }];
    return footer;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeightValue(16.0))];
    header.backgroundColor = [UIColor colorWithHexString:@"383838"];
    return  header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AdaptedHeightValue(64+90+30.0);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0  ) {
        RegisterDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
        [cell changeValue];
    }
}
/**
 确定按钮
 */
#pragma mark - Action
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//手机号码验证
-(BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
-(void)footerBtnPressed{
    if (par.allKeys.count!=9) {
        [SVProgressHUD showWithStatus:@"亲,请完善资料后再提交"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    NSString *contect = par[@"contact"];
    if([self isValidateEmail:contect] || [self validateMobile:contect]){
        
    }else{
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的联系方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    
    

    
    
    if(_type==0){
        [SVProgressHUD show];
        [MobClick event:@"haveCorSubmit"];

//        合作
        [PersonalInfoNet haveCoorWithPar:par success:^{
//            [SVProgressHUD showWithStatus:@"亲,资料我们已收到，请耐心等待客服联系！"];
            [SVProgressHUD dismissWithDelay:0];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [MobClick event:@"moreinfoSub"];

        [PersonalInfoNet getMoreInforMationWithPar:par success:^{
            [SVProgressHUD showWithStatus:@"亲,资料我们已收到，请耐心等待客服联系！"];
            [SVProgressHUD dismissWithDelay:0];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    

    
}
#pragma make -- 返回
-(void)ZJ_CustomNaviLeftButtonClicked{
    

      if(_type==0){
          [MobClick event:@"havCorBack"];

      }else{
          [MobClick event:@"chickmoreinfoBack"];

      }
    
    
    
    if (par.allKeys.count>1) {
        NSString * message = @"你辛苦填写的资料，还没有保存，确定退出吗？";
         NSString * okBtn = @"确定";
         NSString * cancelBtn = @"取消";
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
        return ;
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
