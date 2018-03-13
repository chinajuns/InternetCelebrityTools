//
//  ClaimView.h
//  网红评估工具
//
//  Created by More on 16/10/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClaimView : UIView
+(ClaimView *)instanceTView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextView *reasonTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitBrn;
@property (weak, nonatomic) IBOutlet UIButton *MySelfBtn;
@property (weak, nonatomic) IBOutlet UIButton *agentBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property(nonatomic,strong)NSString *type;
@end
