//
//  UIViewController+CustomCatagory.h
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>
//在controller中使用
#define selfViewSize    self.view.frame.size
#define selfViewWidth   self.view.frame.size.width
#define selfViewHeight  self.view.frame.size.height
#define selfViewXpoint  self.view.frame.origin.x
#define selfViewYpoint  self.view.frame.origin.y

@interface UIViewController (CustomCatagory)
/**
 *  在导航控制器里面获取指定VC的索引
 *
 *  @return 视图控制器索引
 */
-(NSInteger) getVCIndexInNavigationWith:(Class) viewcontroller;

/**
 *  在导航控制器中，获取指定的VC
 *
 *  @param viewController 指定VC
 *
 *  @return VC
 */
-(UIViewController *) getViewControllerInNavigationWith:(Class) viewController;

/**
 *  键盘通知,只有键盘将要出现，将要消失的通知
 */
-(void) registeKeyBoardNotification;

/**
 *  移除所有通知
 */
-(void) unRegisteNotification;

/**
 *  键盘将要出现时的开始边框，和最后的边框
 *
 *  @param beginRect 刚开始的边框
 *  @param endRect   结束后的边框
 */
-(void) keyBoardWillShowBegin:(CGRect) beginRect End:(CGRect) endRect;

/**
 *  键盘将要隐藏时的开始边框，和最后的边框
 *
 *  @param beginRect 刚要隐藏的边框
 *  @param endRect   隐藏完后的边框
 */
-(void) keyBoardWillHiddenBegin:(CGRect) beginRect End:(CGRect) endRect;

/**
 *  默认返回按钮
 */
-(void)ZJ_CustomNaviBackButton;
/**
 *  自定义导航条返回按钮
 *
 *  @param title 自定义标题
 */
-(void) ZJ_CustomNaviBackButton:(NSString *) title;

/**
 *  自定义导航条返回按钮,默认为下一步
 */
-(void) ZJ_CustomNaviRightButton;

/**
 *  自定义导航条返回按钮
 *
 *  @param title 自定义标题
 */
-(void) ZJ_CustomNaviLeftButton:(NSString *) title;

/**
 *  自定义返回按钮
 *
 *  @param image 返回图片
 */
-(void) ZJ_CustomNaviLeftButtonWithImage:(UIImage *) image;

/**
 *  自定义导航条返回按钮
 *
 *  @param title 自定义标题
 */
-(void) ZJ_CustomNaviRightButton:(NSString *) title;

/**
 *  图片按钮
 *
 *  @param image 图片
 */
-(void) ZJ_CustomNaviRightButtonWithImage:(UIImage *) image;

/**
 *  向导航条添加自定义按钮视图
 *
 *  @param image 自定义视图
 */
-(void) ZJ_CustomNaviRightButtonWithCustomView:(UIButton *) customView;

/**
 *  自定义的右边按钮点击事件
 */
-(void) ZJ_CustomNaviRightButtonClicked;

/**
 *  导航条左边按钮点击事件
 */
-(void) ZJ_CustomNaviLeftButtonClicked;
@end
