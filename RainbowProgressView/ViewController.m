//
//  ViewController.m
//  RainbowProgressView
//
//  Created by HarrySun on 2016/10/8.
//  Copyright © 2016年 Mobby. All rights reserved.
//

#import "ViewController.h"
#import "RainbowProgressView.h"
@interface ViewController ()<RainbowProgressViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    RainbowProgressView *rainbowPro = [[RainbowProgressView alloc] initWithFrame:CGRectMake(50, 50, 503, 75)];
    rainbowPro.delegate = self;
    rainbowPro.allTime = 120;
    [rainbowPro startCount];
    [self.view addSubview:rainbowPro];
    
}

/**
 *  代理方法
 */
- (void)presentAlertView{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"时间到了~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.center = self.view.center;
    [self.view addSubview:alertView];
    
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
