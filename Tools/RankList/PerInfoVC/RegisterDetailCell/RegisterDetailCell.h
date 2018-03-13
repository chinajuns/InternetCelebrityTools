//
//  RegisterDetailCell.h
//  钱转转
//
//  Created by More on 16/11/3.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterDetailCell : UITableViewCell<UITextFieldDelegate>
///类型名称
@property(nonatomic,strong)UILabel *typeLable;
///输入框
@property(nonatomic,strong)UITextField *typeTextfield;

//类型Tab
@property(nonatomic,strong)NSString *tagStr;


@property (nonatomic, copy) void(^ChooseImage)(UIImage *image);
@property (nonatomic, copy) void(^ChangePar)(NSString *info);
-(void)changeValue;
@end
