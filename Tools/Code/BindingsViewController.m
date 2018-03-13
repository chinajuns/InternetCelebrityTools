//
//  BindingsViewController.m
//  网红评估工具
//
//  Created by More on 16/9/29.
//  Copyright © 2016年 More. All rights reserved.
//

#import "BindingsViewController.h"
#import "PerInfoViewController.h"
#import "LoginNet.h"
#import "MoreHotRecomVC.h"
@interface BindingsViewController ()<UITextFieldDelegate>{
    NSTimer *codeTimer;
    int time;

}
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation BindingsViewController
- (IBAction)userRoal:(id)sender {
    WebViewController *roalVC = [[WebViewController alloc]init];
    roalVC.title = @"用户协议";
    [self.navigationController pushViewController:roalVC animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.navigationController.navigationBarHidden = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_phoneNumberText.text.length !=11 ||[[_phoneNumberText.text substringWithRange:NSMakeRange(0, 1)] integerValue]!=1 ) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写11位正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }else{
        [_getCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"F56A6B"]];

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.title  = @"完善个人资料";
    _phoneNumberText.delegate =self;
    time=60;
    
    
    UIImageView *lbl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 21)];
    lbl.image  = [UIImage imageNamed:@"手机"];
    lbl.contentMode = UIViewContentModeScaleAspectFit;
    _phoneNumberText.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumberText.leftView = lbl;
    
    
    UIImageView *lbl1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30  , 21)];
    lbl1.image  = [UIImage imageNamed:@"pwd"];
    lbl1.contentMode = UIViewContentModeScaleAspectFit;
    _codeText.leftViewMode = UITextFieldViewModeAlways;
    _codeText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _codeText.leftView = lbl1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super   viewDidDisappear:animated];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
        self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:false];

    _codeText.text = @"";
    
    [codeTimer invalidate];
    _getCodeBtn.enabled = YES;
    [ _getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    

}
- (IBAction)backTolast:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCodeNumber:(id)sender {
    if (_phoneNumberText.text.length !=11 ||[[_phoneNumberText.text substringWithRange:NSMakeRange(0, 1)] integerValue]!=1) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写11位正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    [SVProgressHUD show];
    [BaseNetWork getdataWithString:@"user/getcode" parameters:@{@"mobile":_phoneNumberText.text,@"nickname":_userinfo.name,
                                                                @"head":_userinfo.iconurl,
                                                                @"sex":[_userinfo.gender isEqualToString:@"女"]?@"1":@"2"} scuccessBlock:^(NSDictionary *result) {
                                                                    [MobClick event:@"bindCode"];
         UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:   [NSString stringWithFormat:@"验证码已发送，请注意查收 %@",result] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        _getCodeBtn.enabled = NO;
        time=60;

        codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
        [codeTimer fire];
        [SVProgressHUD dismiss];
                                                                    
        
    } fail:^{
        
    }];
}
- (IBAction)nextStep:(id)sender {
    if (_phoneNumberText.text.length !=11 ||![[_phoneNumberText.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写11位正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    if (_codeText.text.length !=6  ) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    
    [SVProgressHUD show];
    [LoginNet loginWiththirdPla:@{@"mobile":_phoneNumberText.text,
                                  @"code":_codeText.text,
                                  @"nickname":_userinfo.name,
                                  @"sex":[_userinfo.gender isEqualToString:@"男"]? @"1":@"0",
                                  @"head":_userinfo.iconurl,
                                  @"openid":_openID,
                                  @"platform":_platform} successBlock:^ (LoginModel *model) {
                                      DEF_PERSISTENT_SET_OBJECT(model.token, @"LoginToken");
                                      [MobClick event:@"nextBindCode"];

        if([model.isfirst integerValue]==0){
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            MoreHotRecomVC *vc = [story instantiateViewControllerWithIdentifier:@"MoreHotRecomVC"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            if (self.navigationController.parentViewController) {
                [self dismissViewControllerAnimated:NO completion:^{
                    NSLog(@"DISMISS")
                }];
            }else{
                [self performSegueWithIdentifier:@"gotoHome" sender:self];
            }
        }
        [SVProgressHUD dismiss];
        
    }];

  
}
- (IBAction)accpetRoal:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        _nextBtn.enabled = NO;
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    }else{
        _nextBtn.enabled = YES;
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    }
}
-(void)timeStart{
    time-=1;
    if (time>1) {
        [_getCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",time] forState:UIControlStateNormal];
        _getCodeBtn.enabled = NO;

    }else{
        [codeTimer invalidate];

        time=60;
        _getCodeBtn.enabled = YES;
        [ _getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
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
