//
//  MoreTypeChooseVC.m
//  网红评估工具
//
//  Created by More on 16/10/31.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MoreTypeChooseVC.h"
#import "MoreTypeChooseTableViewCell.h"
#import "MoreTypeOtherTableViewCell.h"
@interface MoreTypeChooseVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSArray *typeArr;
    MoreTypeOtherTableViewCell *otherCell ;
    NSString *startStr;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MoreTypeChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
    [self ZJ_CustomNaviRightButton:@"确定"];
    self.title = @"擅长领域";
    typeArr = @[@"时尚",@"美容",@"美食",@"搞笑段子",@"娱乐",@"明星",@"游戏",@"母婴",@"健康",@"宠物",@"科技",@"财经",@"旅游",@"生活"];
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
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    UILabel *other = [[UILabel alloc]init];
    other.text = @"其它:";
    other.textColor = [UIColor whiteColor];
    other.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:other];
    [other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(16+4*50+10);
        make.width.mas_equalTo(40);
    }];
    UITextField *textFiled = [[UITextField alloc]init];
    textFiled.placeholder=@"其它擅长领域";
    textFiled.backgroundColor = [UIColor colorWithHexString:@"FF8481"];
    textFiled.delegate =self;
    [textFiled setBorderStyle:UITextBorderStyleRoundedRect];
        for(NSString  * str in _chooseArr){
            if (![typeArr containsObject:str]) {
                textFiled.text = str;
            }
        }
    textFiled.textColor = [UIColor whiteColor];
    [self.view addSubview:textFiled];
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(other.mas_right).offset = 10;
        make.right.equalTo(self.view.mas_right).offset= -16;
        make.centerY.equalTo(other.mas_centerY);
    }];
    
    

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
        [_chooseArr removeObject:typeArr[btn.tag-100]];
        
    }
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithHexString:@"1c1c1c"];
        
    }else{
        btn.backgroundColor= [UIColor clearColor];
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
    return typeArr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == typeArr.count) {
        return otherCell;
    }
    MoreTypeChooseTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLable.text = typeArr[indexPath.row];
    if ([_chooseArr containsObject:typeArr[indexPath.row]]) {
        cell.isChooseBtn.selected = YES;
    }else{
        cell.isChooseBtn.selected = NO;
    }
    cell.isChooseBtn.tag = 100+ indexPath.row;

    [cell.isChooseBtn addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)changeState:(UIButton *)btn{
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
        [_chooseArr removeObject:typeArr[btn.tag-100]];
        
    }

    
    
}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ZJ_CustomNaviRightButtonClicked{
    self.getBeGoodArr(_chooseArr);
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark textfieleDelegeta
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([_chooseArr containsObject:textField.text]) {
//        包含
        [_chooseArr removeObject:textField.text];
    }else{
        ///不包含
            if (_chooseArr.count == 3) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"最多选择三个擅长领域"
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil];
                [alert show];
                return NO;
            }
    }

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length==0) {
        
    }else{
        [_chooseArr addObject:textField.text];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        if (string.length == 0)
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 5) {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
