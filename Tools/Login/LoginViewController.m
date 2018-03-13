//
//  ViewController.m
//  网红评估工具
//
//  Created by More on 16/9/27.
//  Copyright © 2016年 More. All rights reserved.
//

#import "LoginViewController.h"
#import "YLImageView.h"
#import "YLGIFImage.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LoginNet.h"
#import "BindingsViewController.h"
#import "PerInfoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface LoginViewController ()<UITextFieldDelegate>{
    NSTimer *codeTimer;
    int time;
    
    UMSocialPlatformType plaType;
    UMSocialUserInfoResponse *platInfo;
}
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextfield;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextfield;

@property (weak, nonatomic) IBOutlet UIButton *wbBtn;
@property (weak, nonatomic) IBOutlet UIButton *QQBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UILabel *thirdLable;
@property (weak, nonatomic) IBOutlet UIView *thirdRightView;
@property (weak, nonatomic) IBOutlet UIView *thirdLeftView;


@property(nonatomic ,strong)NSTimer *timer;
@end

@implementation LoginViewController
- (IBAction)userRoal:(id)sender {
            WebViewController *roalVC = [[WebViewController alloc]init];
            roalVC.title = @"用户协议";
            [self.navigationController pushViewController:roalVC animated:YES];
    
}
- (IBAction)accpetRoal:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        _loginBtn.enabled = NO;
        _loginBtn.layer.borderColor = [UIColor colorWithHexString:@"444444"].CGColor;
        [_loginBtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    }else{
        _loginBtn.enabled = YES;
        _loginBtn.layer.borderColor = [UIColor colorWithHexString:@"FF8F9D"].CGColor;
        [_loginBtn setTitleColor:[UIColor colorWithHexString:@"FF8F9D"] forState:UIControlStateNormal];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    self.navigationController.navigationBar.hidden  = YES;
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
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_phoneNumberTextfield.text.length !=11 ||[[_phoneNumberTextfield.text substringWithRange:NSMakeRange(0, 1)] integerValue]!=1 ) {

        return;
    }else{
        [_getCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"F56A6B"]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    UIImageView *lbl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 21)];
    lbl.image  = [UIImage imageNamed:@"手机"];
    lbl.contentMode = UIViewContentModeScaleAspectFit;
    _phoneNumberTextfield.delegate =self;
    _phoneNumberTextfield.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumberTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumberTextfield.leftView = lbl;
  

    UIImageView *lbl1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30  , 21)];
    lbl1.image  = [UIImage imageNamed:@"pwd"];
    lbl1.contentMode = UIViewContentModeScaleAspectFit;
    _codeTextfield.leftViewMode = UITextFieldViewModeAlways;
    _codeTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _codeTextfield.leftView = lbl1;

    
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.borderColor = [UIColor colorWithHexString:@"FF8F9D"].CGColor;;
    _loginBtn.layer.borderWidth=1;
    _loginBtn.clipsToBounds = YES;
    
    time = 60;
}

- (IBAction)loginNow:(id)sender {
    if (_phoneNumberTextfield.text.length !=11 ||![[_phoneNumberTextfield.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写11位正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    if (_codeTextfield.text.length !=6  ) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    
    [SVProgressHUD show];

    [LoginNet loginWithPhoneNumber:_phoneNumberTextfield.text code:_codeTextfield.text successBlock:^ (LoginModel *model) {
//        if([model.isfirst integerValue]==0){
//                [self performSegueWithIdentifier:@"logintoCompa" sender:self];
//        }else{
//            if (self.navigationController.parentViewController) {
//                [self dismissViewControllerAnimated:NO completion:^{
//                }];
//            }else{
                [self performSegueWithIdentifier:@"gotoHomePage" sender:self];
//            }
//        }
        [SVProgressHUD dismiss];

    }];



}
- (IBAction)getCodeBtnPressed:(id)sender {
    if (_phoneNumberTextfield.text.length !=11 ||[[_phoneNumberTextfield.text substringWithRange:NSMakeRange(0, 1)] integerValue]!=1) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写11位正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    [SVProgressHUD show];
   [BaseNetWork getdataWithString:@"user/getcode" parameters:@{@"mobile":_phoneNumberTextfield.text} scuccessBlock:^(NSDictionary *result) {
       [MobClick event:@"getLoginCode"];

       UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:   [NSString stringWithFormat:@"验证码已发送，请注意查收 %@",result] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                      [alertview show];
                      _getCodeBtn.enabled = NO;
                      codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
       [codeTimer fire];
        [SVProgressHUD dismiss];

   } fail:^{
       
   }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)timeStart{
    time-=1;
    if (time>1) {
        [_getCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",time] forState:UIControlStateNormal];
        _getCodeBtn.enabled = NO;

    }else{
        [codeTimer invalidate];

        _getCodeBtn.enabled = YES;
        time=60;
        [ _getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}
- (IBAction)QQLogin:(id)sender {
    [self authWithPlatform:UMSocialPlatformType_QQ];
}
- (IBAction)WBLogin:(id)sender {
    [self authWithPlatform:UMSocialPlatformType_Sina];


}
- (IBAction)WXLogin:(id)sender {
    [self authWithPlatform:UMSocialPlatformType_WechatSession];
}

-(void)authWithPlatform:(UMSocialPlatformType)platformType
{
    
    if ([DEF_PERSISTENT_GET_OBJECT(@"NET") integerValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到网络，请检查网络连接" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [SVProgressHUD dismiss];
        
        return ;
    }


    [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        if (!result) {
            return ;
        }
        NSString *plateform;
        NSString *openId;
        switch (platformType) {
            case UMSocialPlatformType_WechatSession:{
                plateform =@"weixin";
                openId=authresponse.openid;
                [MobClick event:@"loginWithWX"];

            }
                break;
            case UMSocialPlatformType_Sina:{
                plateform =@"weibo";
                openId=authresponse.uid;
                [MobClick event:@"loginWithWB"];

            }
                break;
            case UMSocialPlatformType_QQ:{
                plateform =@"qq";
                openId=authresponse.openid;
                [MobClick event:@"loginWithQQ"];

            }
                break;
                
            default:
                break;
        }
        [SVProgressHUD show];

        [LoginNet loginWithPlatform:plateform openID:openId successBlock:^(NSDictionary *model) {
            [MobClick event:@"loginWithPlatform"];

            NSString *str =model[@"token"];
            ///没绑定手机号
            if(str.length==0){
                if (platformType == plaType) {
                    
                    [self getUserInfoForPlatform:platformType success:^(UMSocialUserInfoResponse *result) {

                        //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
                        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                        //由storyboard根据myView的storyBoardID来获取我们要切换的视图
                        BindingsViewController *vc = [story instantiateViewControllerWithIdentifier:@"BindingsViewController"];
                        //由navigationController推向我们要推向的view
                        vc.userinfo = platInfo;
                        vc.openID = openId;
                        vc.platform = plateform;
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"为完善您的数据信息，请先绑定手机号" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            [self.navigationController pushViewController:vc animated:YES];
                            
                            
                        }];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }];
                }else{
                    
                
                plaType = platformType;
                
                [self getUserInfoForPlatform:platformType success:^(UMSocialUserInfoResponse *result) {
                    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
                    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
                    BindingsViewController *vc = [story instantiateViewControllerWithIdentifier:@"BindingsViewController"];
                    //由navigationController推向我们要推向的view
                    vc.userinfo = result;
                    vc.openID = openId;
                    vc.platform = plateform;
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"为完善您的数据信息，请先绑定手机号" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self.navigationController pushViewController:vc animated:YES];

                        
                    }];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }];
                    
                }
                
                
            }else if(str.length!=0){
                
                DEF_PERSISTENT_SET_OBJECT(model[@"token"], @"LoginToken");
                if (self.navigationController.parentViewController) {
                    [self dismissViewControllerAnimated:NO completion:^{
                        NSLog(@"DISMISS")
                    }];
                }else{
                    [self performSegueWithIdentifier:@"gotoHomePage" sender:self];
                }
                //跳首页
            }
            [SVProgressHUD dismiss];

        }];
    }];
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType success:(void(^)(UMSocialUserInfoResponse * result))succesBlock
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        platInfo = result;
        succesBlock (userinfo);

    }];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _codeTextfield.text = @"";
    //通知主线程刷新
        //回调或者说是通知主线程刷新，
        self.navigationController.navigationBarHidden = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:false];
        
        [codeTimer invalidate];
    _getCodeBtn.enabled = YES;
    [ _getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
}









@end
