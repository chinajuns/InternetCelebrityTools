//
//  SeleBtn.m
//  网红评估工具
//
//  Created by More on 16/10/12.
//  Copyright © 2016年 More. All rights reserved.
//

#import "SeleBtn.h"

@implementation SeleBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if (self ==   [super initWithFrame:frame]) {
        _topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾-拷贝-7"]];
        _topImage.frame = CGRectMake(frame.size.width-6,-4, 12, 12  );
    }
    return self;
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
