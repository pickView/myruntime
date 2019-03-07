//
//  UIViewController+loading.m
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/29.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import "UIViewController+loading.h"
#import <objc/runtime.h>

static int PresnterLoadingViewKey;
static int PresnterLoadingImageViewKey;

static int PresnterBlankViewKey;
static int PresnterBlankMessageLabelKey;

static int PresnterFailureViewKey;
static int PresnterFailureMessageLabelKey;
static int PresnterFailureButtonKey;
static int PresnterRetryButtonCallbackKey;


@implementation UIViewController (loading)

//加载视图
- (void)startLoading{
    [self.view addSubview:self.loadingView];
    [self.loadingImageView startAnimating];
}

//停止加载并消失
- (void)stopLoading{
    [self.loadingImageView stopAnimating];
    [self.loadingView removeFromSuperview];
}
//空白页，如暂无数据
- (void)showBlankView:(UIView *)view message:(NSString *)message{
    [self.view addSubview:self.blankView];
    if ([message isKindOfClass:[NSString class]] && message.length>0) {
        self.blankMessageLabel.text = message;
    }
}
//销毁空白页面
- (void)hideBlankView{
    [self.blankView removeFromSuperview];
}

//加载失败，重新加载
- (void)showFailureViewAndRecallHanlde:(RetryHandler)callBack
                           inContainer:(UIView *)view{
    objc_setAssociatedObject(self, &PresnterRetryButtonCallbackKey, callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);

    [self.view addSubview:self.failureView];

}

- (void)retryButtonAction{
    RetryHandler callBack = objc_getAssociatedObject(self, &PresnterRetryButtonCallbackKey);
    if (callBack) {
        callBack();
    }
}

#pragma mark - Getter

- (UIView *)loadingView{
    UIView *loadingView = objc_getAssociatedObject(self, &PresnterLoadingViewKey);
    if (!loadingView) {
        loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
        objc_setAssociatedObject(self, &PresnterLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        loadingView.backgroundColor = [UIColor whiteColor];
        [loadingView addSubview:self.loadingImageView];
    }
    return loadingView;
}
- (UIImageView *)loadingImageView{
    UIImageView *loadingImageView = objc_getAssociatedObject(self, &PresnterLoadingImageViewKey);
    if (!loadingImageView) {
        loadingImageView = [[UIImageView alloc] initWithFrame:
                     CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height/2 - 80, 200, 150)];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (int i = 0; i <= 80; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"01-progress00%02d.jpg",i]];
            [tmpArr addObject:image];
        }
        [loadingImageView setAnimationImages:[NSArray arrayWithArray:tmpArr]];
        loadingImageView.animationDuration = 2.0;
        objc_setAssociatedObject(self, &PresnterLoadingImageViewKey, loadingImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loadingImageView;
}

- (UIView *)blankView{
    UIView *blankView = objc_getAssociatedObject(self, &PresnterBlankViewKey);
    if (!blankView) {
        blankView = [[UIView alloc] initWithFrame:self.view.bounds];
        objc_setAssociatedObject(self, &PresnterBlankViewKey, blankView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        blankView.backgroundColor = [UIColor whiteColor];
        [blankView addSubview:self.blankMessageLabel];
        
    }
    return blankView;
}

- (UILabel *)blankMessageLabel{
    UILabel *blankMessageLabel = objc_getAssociatedObject(self, &PresnterBlankMessageLabelKey);
    
    if (!blankMessageLabel) {
        blankMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.blankView.bounds.size.height / 3,
                                                                      self.blankView.bounds.size.width - 40, 60)];
        blankMessageLabel.text = @"暂时没有任何数据";
        blankMessageLabel.textColor = [UIColor grayColor];
        blankMessageLabel.numberOfLines = 5;
        blankMessageLabel.textAlignment = NSTextAlignmentCenter;
        blankMessageLabel.backgroundColor = [UIColor clearColor];
        blankMessageLabel.font = [UIFont systemFontOfSize:13];
        
        objc_setAssociatedObject(self, &PresnterBlankMessageLabelKey, blankMessageLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return blankMessageLabel;
}

- (UIView *)failureView{
    UIView *failureView = objc_getAssociatedObject(self, &PresnterFailureViewKey);
    if (!failureView) {
        failureView = [[UIView alloc] initWithFrame:self.view.bounds];
        objc_setAssociatedObject(self, &PresnterFailureViewKey, failureView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        failureView.backgroundColor = [UIColor whiteColor];
        [failureView addSubview:self.failureMessageLabel];
        [failureView addSubview:self.retryButton];
    }
    return failureView;
}

- (UILabel *)failureMessageLabel{
    UILabel *failureMessageLabel = objc_getAssociatedObject(self, &PresnterFailureMessageLabelKey);
    
    if (!failureMessageLabel) {
        failureMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.blankView.bounds.size.height / 3,
                                                                        self.blankView.bounds.size.width - 40, 60)];
        failureMessageLabel.text = @"请求失败，请重试";
        failureMessageLabel.textColor = [UIColor grayColor];
        failureMessageLabel.numberOfLines = 5;
        failureMessageLabel.textAlignment = NSTextAlignmentCenter;
        failureMessageLabel.backgroundColor = [UIColor clearColor];
        failureMessageLabel.font = [UIFont systemFontOfSize:13];
        
        objc_setAssociatedObject(self, &PresnterFailureMessageLabelKey, failureMessageLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return failureMessageLabel;
}

- (UIButton *)retryButton{
    UIButton *retryButton = objc_getAssociatedObject(self, &PresnterFailureButtonKey);
    if (!retryButton) {
        retryButton = [[UIButton alloc] initWithFrame:self.view.bounds];
        retryButton.frame = CGRectMake(self.failureView.bounds.size.width / 2 - 80,
                                       self.failureView.bounds.size.height / 2, 160, 40);
        retryButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [retryButton setTitle:@"重试" forState:UIControlStateNormal];
        [retryButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        retryButton.layer.masksToBounds = YES;
        retryButton.layer.cornerRadius = 4;
        retryButton.layer.borderWidth = 1;
        retryButton.layer.borderColor = [UIColor blueColor].CGColor;
        
        [retryButton addTarget:self action:@selector(retryButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        objc_setAssociatedObject(self, &PresnterFailureButtonKey, retryButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return retryButton;
}




@end
