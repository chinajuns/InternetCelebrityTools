//
//  CustomHeadImageVC.m
//  网红评估工具
//
//  Created by More on 16/11/15.
//  Copyright © 2016年 More. All rights reserved.
//

#import "CustomHeadImageVC.h"
#import "UIButton+WebCache.h"

@interface CustomHeadImageVC (){
    NSArray *imags ;
}

@end

@implementation CustomHeadImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backImg.image = [UIImage imageNamed:@"Background"];
    [self.view addSubview:backImg];
    self.title  = @"选择头像";
    [self ZJ_CustomNaviLeftButtonWithImage:[UIImage imageNamed:@"上一页"]];
   imags =  @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpeg",@"10.jpeg",@"11.jpeg",@"12.jpeg",@"13.png",@"14.jpg",];
    CGFloat  width  = (SCREEN_WIDTH-25)/4.0;
    for (int i = 0; i < imags.count; i++) {
        UIButton  *image = [[UIButton alloc]initWithFrame:CGRectMake(i%4*width+(i%4+1)* 5 , 64+i/4*width +(i/4+1)* 5 ,width, width)];
        [image setImage:[UIImage imageNamed:imags[i]] forState:UIControlStateNormal];
   
        image.imageView.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        image.layer.cornerRadius = 5;
        image.clipsToBounds = YES;
        image.tag=100+i;
        [image addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:image];
        
    }

    // Do any additional setup after loading the view.
}
-(void)selectImage:(UIButton *)sender{
    UIImage *image = [UIImage imageNamed:imags[sender.tag-100]];
    _ChooseImage(image);
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ZJ_CustomNaviLeftButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
