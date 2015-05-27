//
//  ViewController.m
//  BannerDemo
//
//  Created by zhengzeqin on 15/5/27.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//

#import "ViewController.h"
#import "BannerObject.h"
#import "BannerView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *bannerArr = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        BannerObject *object = [[BannerObject alloc]init];
        object.imgUrl = [NSString stringWithFormat:@"%d",i+1];
        [bannerArr addObject:object];
    }
    BannerView *banner = [[BannerView alloc]init];
    banner.ifNoCycle = YES;
    [banner setBannerViewWithArr:bannerArr];
    [self.contentView addSubview:banner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
