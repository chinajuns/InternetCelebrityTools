//
//  RegisterSexChooseCell.m
//  钱转转
//
//  Created by More on 16/11/3.
//  Copyright © 2016年 More. All rights reserved.
//

#import "RegisterUpdataPhotoCell.h"

@implementation RegisterUpdataPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _flag= 0;
        UIView *titleView = [[UIView alloc]init];
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height .mas_equalTo(AdaptedHeightValue(120));
        }];
        
        _typeLable =[[UILabel alloc]init];
        _typeLable.text = @"证明材料";
        _typeLable.textColor = [UIColor colorWithHexString:@"ffffff"];
        _typeLable.font = [UIFont systemFontOfSize:15];
        _typeLable.textAlignment = NSTextAlignmentLeft;
        [titleView addSubview:_typeLable];
        CGFloat width = 150;
        [_typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidthValue(40));
            make.centerY.equalTo(titleView.mas_centerY);
            make.width.mas_equalTo(width);
        }];

        _typeDetialLable =[[UILabel alloc]init];
        _typeDetialLable.text = @"名片/聘书/工牌";
        _typeDetialLable.textColor = [UIColor colorWithHexString:@"999999"];
        _typeDetialLable.font = [UIFont systemFontOfSize:15];
        _typeDetialLable.textAlignment = NSTextAlignmentLeft;
        [titleView addSubview:_typeDetialLable];
        [_typeDetialLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset=-AdaptedWidthValue(30);
            make.centerY.equalTo(titleView.mas_centerY);
        }];
        
        UIView *imagesView = [[UIView alloc]init];
        [self addSubview:imagesView];
        [imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleView.mas_bottom);
            make.left.mas_equalTo(AdaptedWidthValue(30));
            make.right.mas_equalTo(-AdaptedWidthValue(30));
            make.height.mas_equalTo(AdaptedHeightValue(300));
        }];
        imagesView.layer.borderWidth=1;
        imagesView.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
        
        _firstUPBtn = [[UIButton alloc]init];
        [_firstUPBtn setImage:[UIImage imageNamed:@"wanshanziliao_icon_tjtp"] forState:UIControlStateNormal];
        [_firstUPBtn addTarget:self action:@selector(firstBtnPressed) forControlEvents:UIControlEventTouchUpInside  ];
        [imagesView addSubview:_firstUPBtn];
        [_firstUPBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidthValue(70));
            make.centerY.equalTo(imagesView.mas_centerY);
            make.width.mas_equalTo(AdaptedWidthValue(250));
            make.height.mas_equalTo(AdaptedHeightValue(160));
        }];
        
        
        _seconedUPBtn = [[UIButton alloc]init];
        [_seconedUPBtn setImage:[UIImage imageNamed:@"wanshanziliao_icon_tjtp"] forState:UIControlStateNormal];
        [_seconedUPBtn addTarget:self action:@selector(secondBtnPressed) forControlEvents:UIControlEventTouchUpInside    ];
        [imagesView addSubview:_seconedUPBtn];
        [_seconedUPBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-AdaptedWidthValue(70));
            make.centerY.equalTo(imagesView.mas_centerY);
            make.width.mas_equalTo(AdaptedWidthValue(250));
            make.height.mas_equalTo(AdaptedHeightValue(160));
        }];
        
    
        
        
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)firstBtnPressed{
    _flag = 1;
    [self chooseImage];
    
}
-(void)secondBtnPressed{
    _flag = 2;
    [self chooseImage];
}
#pragma changeHeader
- (void)chooseImage {
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [AuthorizationOBJ AlbumAuthorizationWithSuccessBlock:^{
            //            初始化UIImagePickerController
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
            [[self getCurrentViewController] presentViewController:PickerImage animated:YES completion:nil];
        } failBlcok:^{
            NSString *tips = @"请授权本App可以访问相册\n设置方式:手机设置->隐私->相机\n允许本App访问相册";
            
            [[self getCurrentViewController] presentViewController:[WMZUIalertVC CreatAlertWithTitle:@"提示" message:tips CancelBtn:@"确定" cancelBlock:^{
                //无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            } OKBtn:@"取消" OKBlock:^{
                
            }]
                               animated:YES completion:^{
                                   
                               }];
        }];
        
        
        
        
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [AuthorizationOBJ CameraAuthorizationWithSuccessBlock:^{
            
            /**
             其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
             */
            
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式:通过相机
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            PickerImage.allowsEditing = YES;
            PickerImage.delegate = self;
            [[self getCurrentViewController] presentViewController:PickerImage animated:YES completion:nil];
            
        } failBlcok:^{
            NSString *tips = @"请授权本App可以访问相册\n设置方式:手机设置->隐私->相机\n允许本App访问相册";
            
            [[self getCurrentViewController]  presentViewController:[WMZUIalertVC CreatAlertWithTitle:@"提示" message:tips CancelBtn:@"确定" cancelBlock:^{
                // 无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            } OKBtn:@"取消" OKBlock:^{
                
            }]
                               animated:YES completion:^{
                                   
                               }];
        }];
        
        
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[self getCurrentViewController] presentViewController:alert animated:YES completion:nil];

}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if(_flag==1){
        [SVProgressHUD showWithStatus:@"图片上传中"];

        [BaseNetWork upLoadFileWithImage:newPhoto preGress:^(CGFloat progress) {
            NSLog(@"%lf",progress);
        } success:^(NSString *result) {
            if (_ChooseFirImage) {
                _ChooseFirImage(result);

            }

            [SVProgressHUD showWithStatus:@"图片上传成功"];
            [SVProgressHUD dismissWithDelay:1];
            
        }];
        [_firstUPBtn setImage:newPhoto forState:UIControlStateNormal];
    }else{
        [SVProgressHUD showWithStatus:@"图片上传中"];

        [BaseNetWork upLoadFileWithImage:newPhoto preGress:^(CGFloat progress) {
            NSLog(@"%lf",progress);
        } success:^(NSString *result) {
            if(_ChooseSecondImage){
            _ChooseSecondImage(result);
            }
            [SVProgressHUD showWithStatus:@"图片上传成功"];
            [SVProgressHUD dismissWithDelay:1];
            
        }];
        [_seconedUPBtn setImage:newPhoto forState:UIControlStateNormal];
    }
    _flag = 0;
    [[self getCurrentViewController] dismissViewControllerAnimated:YES completion:nil];
}
-(void)changeValue
{
}
@end
