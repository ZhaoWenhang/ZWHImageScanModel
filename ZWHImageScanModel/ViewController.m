//
//  ViewController.m
//  ZWHImageScanModel
//
//  Created by wenhang on 2017/4/7.
//  Copyright © 2017年 wenhang. All rights reserved.
//

#import "ViewController.h"
#import "ZWHImageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //一句代码搞定
    
    ZWHImageView *imgView = [[ZWHImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 200) imageName:@"cat" contentMode:UIViewContentModeScaleAspectFit ifCheckBigImage:YES];
    
    [self.view addSubview:imgView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
