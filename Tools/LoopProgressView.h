//
//  LoopProgressView.h
//  网红评估工具
//
//  Created by More on 16/11/9.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopProgressView : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong)CAShapeLayer *arcLayer;

-(void)drawLineAnimation:(CALayer*)layer;
@end
