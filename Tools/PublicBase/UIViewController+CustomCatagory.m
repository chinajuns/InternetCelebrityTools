//
//  UIViewController+CustomCatagory.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "UIViewController+CustomCatagory.h"
#define ToolKit_SubClassNotPerformSelector(selector) NSLog(@"子类: %@  \n未实现方法: %@",self,NSStringFromSelector(selector));

@implementation UIViewController (CustomCatagory)


//最前面的视图控制器
-(UIViewController *) getCurrentViewController{
    if (self.presentedViewController == nil) {//当前ViewController没有present任何Controller
        return [self getCurrentViewController];
    }
    if([self isKindOfClass:[UITabBarController class]]){//如果是tabbar控制栏
        UIViewController *tabbarVC =  [(UITabBarController *) self selectedViewController];
        return [tabbarVC getCurrentViewController];
    }else if ([self isKindOfClass:[UINavigationController class]]){//如果是导航控制器
        UINavigationController *navigation = (UINavigationController *) self;
        return [navigation.visibleViewController getCurrentViewController];
    }
    return self;
}

-(NSInteger) getVCIndexInNavigationWith:(Class )viewcontroller{
    for (NSInteger index = 0; index < self.navigationController.childViewControllers.count; index ++) {
        if ([[self.navigationController.childViewControllers objectAtIndex:index] isKindOfClass:viewcontroller]) {
            return index;
        }
    }
    return NSNotFound;
}

-(UIViewController *) getViewControllerInNavigationWith:(Class)viewController{
    NSInteger index = [self getVCIndexInNavigationWith:viewController];
    if (index != NSNotFound)
        return [self.navigationController.childViewControllers objectAtIndex:index];
    return nil;
}

-(void) registeKeyBoardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) unRegisteNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) keyBoardWillShow:(NSNotification *) notificatiton{
    NSDictionary *userInfo = [notificatiton userInfo];
    NSValue *keyboardEnd = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *keyboardBegin = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGRect keyboardEndRect = keyboardEnd.CGRectValue;
    CGRect keyboardBeginRect = keyboardBegin.CGRectValue;
    
    [self keyBoardWillShowBegin:keyboardBeginRect End:keyboardEndRect];
}

-(void) keyBoardWillHide:(NSNotification *) notificatiton{
    NSDictionary *userInfo = [notificatiton userInfo];
    NSValue *keyboardEnd = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *keyboardBegin = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGRect keyboardEndRect = keyboardEnd.CGRectValue;
    CGRect keyboardBeginRect = keyboardBegin.CGRectValue;
    [self keyBoardWillHiddenBegin:keyboardBeginRect End:keyboardEndRect];
}

-(void) keyBoardWillShowBegin:(CGRect)beginRect End:(CGRect)endRect{
    ToolKit_SubClassNotPerformSelector(_cmd);
}

-(void) keyBoardWillHiddenBegin:(CGRect)beginRect End:(CGRect)endRect{
    ToolKit_SubClassNotPerformSelector(_cmd);
}

#pragma mark -
#pragma mark 导航栏
-(void) ZJ_CustomNaviBackButton{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:nil
                                                                        action:nil];
    self.navigationItem.backBarButtonItem = returnButtonItem;
}

-(void) ZJ_CustomNaviBackButton:(NSString *) title{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:nil
                                                                        action:nil];
    self.navigationItem.backBarButtonItem = returnButtonItem;
}

-(void) ZJ_CustomNaviLeftButton:(NSString *)title{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(ZJ_CustomNaviLeftButtonClicked)];
    returnButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = returnButtonItem;
}

-(void) ZJ_CustomNaviLeftButtonWithImage:(UIImage *)image{
    
    UIButton  *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
    imageView.frame = CGRectMake(0, 0, image.size.width, 50);
    [imageView setImage:image forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(ZJ_CustomNaviLeftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
}
-(void) ZJ_CustomNaviRightButton{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"下一步"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(ZJ_CustomNaviRightButtonClicked)];
    rightButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void) ZJ_CustomNaviRightButton:(NSString *)title{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:title
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(ZJ_CustomNaviRightButtonClicked)];
    rightButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void) ZJ_CustomNaviRightButtonWithImage:(UIImage *)image{
    UIButton  *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [imageView setImage:image forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(ZJ_CustomNaviRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}


-(void) ZJ_CustomNaviRightButtonWithCustomView:(UIButton *)customView{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:customView];
    [customView addTarget:self action:@selector(ZJ_CustomNaviRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void) ZJ_CustomNaviRightButtonClicked{
    ToolKit_SubClassNotPerformSelector(_cmd);
}

-(void) ZJ_CustomNaviLeftButtonClicked{
    ToolKit_SubClassNotPerformSelector(_cmd);
}

@end
