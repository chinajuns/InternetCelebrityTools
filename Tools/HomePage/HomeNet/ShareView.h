//
//  ShareView.h
//  网红评估工具
//
//  Created by More on 16/10/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol shareDelegeta
-(void)shareToPlaWithTag:(int )tag;

@end

@interface ShareView : UIView
@property(nonatomic,weak)id <shareDelegeta> delegate;
+(ShareView *)instanceTView;

@end
