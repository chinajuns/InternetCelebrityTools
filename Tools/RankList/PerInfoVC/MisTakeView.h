//
//  MisTakeView.h
//  网红评估工具
//
//  Created by More on 16/10/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MisTakeView : UIView
+(MisTakeView *)instanceTView;
@property (weak, nonatomic) IBOutlet UITextView *raasonText;
@property (weak, nonatomic) IBOutlet UIButton *subMitBtn;
@property (weak, nonatomic) IBOutlet UIButton *baseBtn;
@property (weak, nonatomic) IBOutlet UIButton *rankInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property(nonatomic,strong)NSString *type;
@end
