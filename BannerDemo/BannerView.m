//
//  BannerView.m
//  Pokitfood
//
//  Created by zhengzeqin on 15/4/20.
//  Copyright (c) 2015年 Injoinow. All rights reserved.
//

#import "BannerView.h"
#import "UIImageView+WebCache.h"
@interface BannerView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic)NSArray *bannerArr;
//多存两个数据的数组
@property (strong, nonatomic)NSMutableArray *bannerMutableArr;
@property (assign, nonatomic)NSInteger currentPage;

@end
@implementation BannerView

#pragma mark - setter && getter
- (NSMutableArray *)bannerMutableArr{
    
    if (!_bannerMutableArr) {
        _bannerMutableArr = [NSMutableArray array];
    }
    return _bannerMutableArr;
}

#pragma mark - cyclelife
- (instancetype)initWithBannerArr:(NSArray *)bannerArr{
    
    if (self = [self init]) {
        
        self.bannerArr = bannerArr;
        [self initScrollView];
        [self initPageControl];
    }
    return self;
}

- (instancetype)init{

    if (self = [super init]) {
        
       self = [[[NSBundle mainBundle]loadNibNamed:@"BannerView" owner:nil options:nil]firstObject];
    }
    return self;
}

- (void)awakeFromNib{
    self.currentPage = 1;//默认第1页开始
}
#pragma mark - function

//设置scrollView数据大小
- (void)setBannerViewWithArr:(NSArray *)bannerArr{
    self.bannerArr = bannerArr;
    [self initScrollView];
    [self initPageControl];
}
- (void)initPageControl{
    self.pageControl.numberOfPages = self.bannerArr.count;
}

- (void)initScrollView{
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (self.bannerArr.count+2), self.scrollView.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    //偏移
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    //添加图片
    for (int i = 0 ; i < self.bannerArr.count+2; i++) {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        imgView.tag = i;
        imgView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imgView];
        BannerObject *bannerObject;
        if (i == 0){
            bannerObject = self.bannerArr[self.bannerArr.count-1];
        }else if(i == self.bannerArr.count+1){
            bannerObject = self.bannerArr[0];
        }else{
            bannerObject = self.bannerArr[i-1];
        }
        [self.bannerMutableArr addObject:bannerObject];
        //网络加载
//        [imgView sd_setImageWithURL:[NSURL URLWithString:bannerObject.imgUrl]];
        //本地加载
        imgView.image = [UIImage imageNamed:bannerObject.imgUrl];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouch:)];
        [imgView addGestureRecognizer:tap];
    }
    if (!self.ifNoCycle) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
}
//滚动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    self.currentPage = (NSInteger) scrollView.contentOffset.x/scrollView.frame.size.width;
    [self scrollViewRoll:scrollView];
    
}

- (void)scrollViewRoll:(UIScrollView *)scrollView{
    //CABCA
    if (scrollView.contentOffset.x == 0){
        //当滚动到第一张的时候。偏移到第倒数第二张
        scrollView.contentOffset = CGPointMake(self.bannerArr.count*scrollView.frame.size.width, 0);
    }else if (scrollView.contentOffset.x == scrollView.frame.size.width * (self.bannerArr.count+1)){
        //当滚动到最后一张时。偏移到第二张
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }
    self.pageControl.currentPage = (NSInteger) scrollView.contentOffset.x/scrollView.frame.size.width - 1;
}
- (void)imgTouch:(UITapGestureRecognizer *)sender{
    UIImageView *imgV = (UIImageView *)sender.view;
    BannerObject *bannerObject = self.bannerMutableArr[imgV.tag];
    NSLog(@"bannerObjectUrl = %@",bannerObject.imgUrl);
}


//定时器
- (void)timeStart{
    
    self.currentPage++;
    self.currentPage = self.currentPage % self.bannerArr.count;
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.currentPage*self.scrollView.frame.size.width, 0);
    }];
    [self scrollViewRoll:self.scrollView];
}

@end
