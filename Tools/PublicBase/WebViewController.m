//
//  WebViewController.m
//  魔漾app
//
//  Created by More on 16/5/20.
//  Copyright © 2016年 明航mac. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController (){
    UIWebView *web_View;
}

@end

@implementation WebViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden= YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];

    web_View =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [web_View loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://testhot.cdmoreyoung.com/index.php?r=share/notice"]]];
    [self.view addSubview:web_View];

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma make -- 返回
-(void)ZJ_CustomNaviLeftButtonClicked{
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
