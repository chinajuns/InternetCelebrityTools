//
//  ThirdPLNameAndID.h
//  网红评估工具
//
//  Created by More on 16/10/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdPLNameAndID : UIView
@property (weak, nonatomic) IBOutlet UITextField *IDTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *configBtn;
+(ThirdPLNameAndID *)instanceTView;

@end
