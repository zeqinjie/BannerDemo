//
//  BannerObject.h
//  Pokitfood
//
//  Created by zhengzeqin on 15-4-17.
//  Copyright (c) 2015年 Injoinow. All rights reserved.
//
/**
 *  @brief  广告横幅对象
 */
#import <Foundation/Foundation.h>

@interface BannerObject : NSObject

//广告图片
@property (copy, nonatomic)NSString *imgUrl;
//连接地址
@property (copy, nonatomic)NSString *link;

@end
