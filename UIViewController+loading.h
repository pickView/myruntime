//
//  UIViewController+loading.h
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/29.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RetryHandler)();

@interface UIViewController (loading)
//开始加载
- (void)startLoading;
//结束或暂停加载
- (void)stopLoading;
//空白页面 暂无数据
- (void)showBlankView:(UIView *)view message:(NSString *)message;
//销毁空白页面
- (void)hideBlankView;
//显示错误提示页面
- (void)showFailureViewAndRecallHanlde:(RetryHandler)callBack
                           inContainer:(UIView *)view;
@end
