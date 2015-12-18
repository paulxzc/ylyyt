//
//  BannerTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BannerTableViewCell.h"
#import "MainPage.h"
#import "Banner.h"

@interface BannerTableViewCell()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *bannerImageView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (nonatomic, strong) MainPage *mainPage;

@end

@implementation BannerTableViewCell

- (void)refreshCell:(MainPage*)mainPage{
    
    _mainPage = mainPage;
    
    Banner *banner0 = mainPage.ba[0];
    Banner *banner2 = mainPage.ba[2];
    
    NSMutableArray *imagesArr = [[NSMutableArray alloc] initWithCapacity:0];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",banner2.imageName]];
    [imagesArr addObject:image];
    
    for (int i = 0; i < 3; i++) {
        Banner *banner = mainPage.ba[i];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",banner.imageName]];
        [imagesArr addObject:image];
    }
    
    UIImage *imageLast = [UIImage imageNamed:[NSString stringWithFormat:@"%@",banner0.imageName]];
    [imagesArr addObject:imageLast];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.35*SCREEN_HEIGHT)];
    _scrollView.bounces = NO;
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imagesArr.count, 0.35*SCREEN_HEIGHT);
    //    _scrollView.alwaysBounceHorizontal = YES;//横向一直可拖动
    _scrollView.pagingEnabled = YES;//关键属性，打开page模式。
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;//不要显示滚动条~
    [self addSubview:_scrollView];
    
    
    for (int i = 0; i < imagesArr.count; i++) {
        self.bannerImageView = [[UIImageView alloc] initWithImage:imagesArr[i]];
        self.bannerImageView.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 0.35*SCREEN_HEIGHT);
        [_scrollView addSubview:self.bannerImageView];
        
        UIButton *bannerBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 0.35*SCREEN_HEIGHT)];
        bannerBtn.backgroundColor = [UIColor clearColor];
        bannerBtn.tag = i;
        [bannerBtn addTarget:self action:@selector(pushToBanner:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:bannerBtn];
    }
    
    CGSize size = [self.pageControl sizeForNumberOfPages:imagesArr.count];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.pageControl.center = CGPointMake(SCREEN_WIDTH/2, 0.35*SCREEN_HEIGHT-10);
    self.pageControl.numberOfPages = imagesArr.count - 2;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    //    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)pushToBanner:(UIButton *)sender{
    Banner *banner = _mainPage.ba[sender.tag-1];
    [self.delegate pushBanner:banner.linkUrl];    
}

- (void)pageChanged:(UIPageControl*)pageControl{
    [self.scrollView setContentOffset:CGPointMake(pageControl.currentPage*SCREEN_WIDTH, 0) animated:YES];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    int page = scrollView.contentOffset.x/SCREEN_WIDTH;
//    if (page == 0 || page == 5) {
//        if (page == 0) {
//            page = 4;
//        }else{
//            page = 1;
//        }
//        [scrollView setContentOffset:CGPointMake(page*SCREEN_WIDTH, 0)];
//    }
//    self.pageControl.currentPage = page-1;
//}

//减速完成时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (currentPage == 0 || currentPage == 4) {
        if (currentPage == 0) {
            currentPage = 3;
        }else{
            currentPage = 1;
        }
        [scrollView setContentOffset:CGPointMake(currentPage*SCREEN_WIDTH, 0)];
    }
    //同步
    _pageControl.currentPage = currentPage-1;
    
}

@end
