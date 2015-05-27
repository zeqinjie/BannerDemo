//
//  BannerView.h
//  Pokitfood
//
//  Created by zhengzeqin on 15/4/20.
//  Copyright (c) 2015年 Injoinow. All rights reserved.
//
/**
 自动滚动的广告横幅类
 捆绑BannerObject类带以下参数
 //广告图片
 @property (copy, nonatomic)NSString *imgUrl;
 //连接地址
 @property (copy, nonatomic)NSString *link;
 */
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "BannerObject.h"
@interface BannerView : UIView
//是否停止自动轮循 默认是0 自动轮播 
@property (nonatomic, assign)BOOL ifNoCycle;
/*初始化广告横幅，带广告对象数组**/
- (instancetype)initWithBannerArr:(NSArray *)bannerArr;
/*设置广告数据**/
- (void)setBannerViewWithArr:(NSArray *)bannerArr;

@end
