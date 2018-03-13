//
//  ThirdPLNameAndID.m
//  网红评估工具
//
//  Created by More on 16/10/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import "ThirdPLNameAndID.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation ThirdPLNameAndID
+(ThirdPLNameAndID *)instanceTView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ThirdPLNameAndID" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (IBAction)confNow:(id)sender {
    
    [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
        if(!result){
            return ;
        }
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
            UMSocialUserInfoResponse *userinfo =result;
            _IDTextField.text = userinfo.name;
        }];

    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
