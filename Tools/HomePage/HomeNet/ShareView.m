//
//  ShareView.m
//  网红评估工具
//
//  Created by More on 16/10/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView
+(ShareView *)instanceTView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)shareToQzone {
    NSLog(@"shareToQzone");
    [self.delegate shareToPlaWithTag:1];
}
- (IBAction)shareToQQ {
    NSLog(@"shareToQQ");

    [self.delegate shareToPlaWithTag:2];
}
- (IBAction)shareToWX {
    NSLog(@"shareToWX");

    [self.delegate shareToPlaWithTag:3];
}
- (IBAction)shareToWf {
    NSLog(@"shareToWf");

    [self.delegate shareToPlaWithTag:4];
}
- (IBAction)shareToSina {
    NSLog(@"shareToSina");

    [self.delegate shareToPlaWithTag:5];
}

@end
