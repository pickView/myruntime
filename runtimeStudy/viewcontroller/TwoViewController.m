//
//  TwoViewController.m
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/29.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import "TwoViewController.h"
#import "UIViewController+loading.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self startLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopLoading];
        //加载完毕，暂无数据
        //[self showBlankView:self.view message:@"暂无数据，请稍后再试"];
        //加载失败
        [self showFailureViewAndRecallHanlde:^{
            NSLog(@"点击了");
        } inContainer:self.view];
    });
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"current row is %d",(int)indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Bradley Hand" size:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
