//
//  MorePlatformVc.m
//  网红评估工具
//
//  Created by More on 16/10/31.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MorePlatformVc.h"
#import "MorePlatCell.h"
#import "MorePlaOtherCell.h"
@interface MorePlatformVc ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSArray *typeArr;

    NSMutableArray *cellArr;
    MorePlaOtherCell  *otherCell;
}

@end

@implementation MorePlatformVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    [self ZJ_CustomNaviRightButton:@"确定"];
    self.title = @"常用平台";
    _chooseArr = [[NSMutableArray alloc]init];

    self.view.backgroundColor = [UIColor colorWithHexString:@"383838"];
    [_chooseArr addObjectsFromArray:_dataDic.allKeys];
    typeArr = @[@"新浪微博",@"微信公众号",@"美拍",@"秒拍",@"映客",@"bilibili",@"其它"];
    CGFloat width = (SCREEN_WIDTH-5*16)/4;
    for (int i = 0 ; i < typeArr.count; i++) {
        UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(16+i%4*(width+16), 16 + i/4* 50, width, 40) ];
        [btn setTitle:typeArr[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 8;
        btn.clipsToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor colorWithHexString:@"1c1c1c"].CGColor;
        btn.layer.borderWidth = 1;
        btn.titleLabel.minimumScaleFactor = 0.1;
        btn.tag=100+i;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        if([_chooseArr containsObject:typeArr[i]]){
            btn.selected = YES;
            btn.backgroundColor = [UIColor colorWithHexString:@"1c1c1c"];
        }
        if (i == typeArr.count-1) {
            for (NSString *value in _chooseArr) {
                if(![typeArr containsObject:value]){
                    btn.selected = YES;
                    btn.backgroundColor = [UIColor colorWithHexString:@"1c1c1c"];
                    break;
                }
            }
         
            
        }
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }

    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView registerNib:[UINib nibWithNibName:@"MorePlatCell" bundle:nil] forCellReuseIdentifier:@"PlatCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"MorePlaOtherCell" bundle:nil] forCellReuseIdentifier:@"PlatOtherCell"];
    // Do any additional setup after loading the view.
    cellArr =  [[NSMutableArray alloc]init];
    for (int i = 0 ; i < typeArr.count; i++) {
        MorePlatCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"PlatCell"];
        
        if (i==0) {
            cell.thirdPla.IDTextField .enabled =NO;
            cell.thirdPla.configBtn.hidden =NO;
            cell.thirdPla.IDTextField.backgroundColor = [UIColor clearColor];
        }else{
            cell.thirdPla.IDTextField .enabled =YES;
            cell.thirdPla.configBtn.hidden =YES;
        }
        if ([_dataDic.allKeys containsObject:typeArr[i]]) {
            cell.thirdPla.IDTextField.text = [_dataDic objectForKey:typeArr[i]];
        }
    
        cell.thirdPla.IDTextField.tag = 100+i;
        cell.thirdPla.IDTextField.delegate = self;
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
         cell.thirdPla.IDTextField.leftView = leftView;
         cell.thirdPla.IDTextField.leftViewMode = UITextFieldViewModeAlways;
         cell.thirdPla.IDTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        cell.thirdPla.IDTextField.layer.cornerRadius = 8 ;
        cell.thirdPla.IDTextField.clipsToBounds = YES;
        cell.thirdPla.titleLable.text = typeArr[i];
        cell.backgroundColor  = [UIColor clearColor];
        [cellArr addObject:cell];
    }
    for (NSString *str  in _dataDic.allKeys) {
        if(![typeArr containsObject:str]){
            
        }
    }
    otherCell = [_tableView dequeueReusableCellWithIdentifier:@"PlatOtherCell"];
    for (NSString *str  in _dataDic.allKeys) {
        if(![typeArr containsObject:str]){
            otherCell.plaNameText.text  = str;
            otherCell.idName.text  = [_dataDic objectForKey:str];
        }
    }
    
    
    
    otherCell.backgroundColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(16+2*50+10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _chooseArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellName = _chooseArr[indexPath.row];
    if (![typeArr containsObject:cellName] || [cellName isEqualToString:@"其它"] ) {
        return otherCell;
    }
    NSInteger index =  [typeArr indexOfObject:_chooseArr[indexPath.row]];
    
    
    return cellArr[index];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellName = _chooseArr[indexPath.row];

    if (![typeArr containsObject:cellName] || [cellName isEqualToString:@"其它"]) {
        return 95;
    }
    return 70;
}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ZJ_CustomNaviRightButtonClicked{
//    self.getBeGoodArr(_chooseArr);
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    for (int i = 0;i <cellArr.count;i++) {
        MorePlatCell *cell  = cellArr[i];
        if (cell.thirdPla.IDTextField.text.length >0) {
            [dic setObject:cell.thirdPla.IDTextField.text forKey:typeArr[i]];
        }
    }
    if (otherCell.plaNameText.text.length!=0 && otherCell.idName.text.length!=0) {
        [dic setObject: otherCell.idName.text forKey:otherCell.plaNameText.text  ];

    }
    if (dic.allKeys.count>3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"最多选择三个平台"
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSLog(@"%@",dic);
    self.choosePlatS(dic);
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark textfieleDelegeta
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_Sina completion:^(id result, NSError *error) {

        [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
                UMSocialUserInfoResponse *userinfo =result;
                textField.text = userinfo.name;
            }];

        }];
    }];
        return YES;;

    }
    
//    
//    if ([_chooseArr containsObject:textField.text]) {
//        [_chooseArr removeObject:textField.text];
//    }else{
//        ///不包含
//        if (_chooseArr.count == 3) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"最多选择三个擅长领域"
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
//            return NO;
//        }
//    }
    
    return YES;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField.text.length==0) {
//    }else{
//        [_chooseArr addObject:textField.text];
//    }
//    NSLog(@"%@",_chooseArr);
//}
- (NSString *)transformToPinyin:(NSString *)str {
    NSMutableString *mutableString = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    return mutableString;
}

-(void)btnPressed:(UIButton *)btn{
    if (!btn.selected && _chooseArr.count == 3) {
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
        [_chooseArr addObject:typeArr[btn.tag-100]];
    }else{
        
        NSString *cellName = typeArr[btn.tag-100];
        
        if ([_chooseArr containsObject:cellName]) {
            NSInteger index  = [_chooseArr indexOfObject:cellName];
            MorePlatCell *cell =   cellArr[index];
            cell.thirdPla.IDTextField.text = @"";
            [_chooseArr removeObject:cellName];

        }else{
            [_chooseArr removeObject:otherCell.plaNameText.text];

            otherCell.plaNameText.text =@"";
            otherCell.idName.text =@"";

        }
        

        
        
    }
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithHexString:@"1c1c1c"];
        
    }else{
        btn.backgroundColor= [UIColor clearColor];
    }
    [_tableView reloadData];
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
