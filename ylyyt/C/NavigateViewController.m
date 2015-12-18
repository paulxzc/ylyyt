//
//  NavigateViewController.m
//  ylyyt
//
//  Created by apple on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NavigateViewController.h"
#import "RootTabBarController.h"


@implementation NavigateViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //我们的scrollView的frame应该是屏幕大小
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //但是我们希望我们scrollView的可被展现区域是4个屏幕横排那么大
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    _scrollView.alwaysBounceHorizontal = YES;//横向一直可拖动
    _scrollView.pagingEnabled = YES;//关键属性，打开page模式。
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;//不要显示滚动条~
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"裕林医药通启动界面%d.jpg",i+2];
        UIImage *image = [UIImage imageNamed:imageName];
        self.navigateImageView = [[UIImageView alloc] initWithImage:image];
        self.navigateImageView.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_scrollView addSubview:self.navigateImageView];
    }
    
    CGSize size = [self.pageControl sizeForNumberOfPages:3];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.pageControl.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-50);
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.13*SCREEN_WIDTH, 0.73*SCREEN_HEIGHT, 0.71*SCREEN_WIDTH, 0.07*SCREEN_HEIGHT)];
    startBtn.backgroundColor = [UIColor clearColor];
    [startBtn addTarget:self action:@selector(pushToStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
   
}

//-(void)viewDidAppear:(BOOL)animated{
//    
//    [self.view setBackgroundColor:[UIColor clearColor]];
//    
//    //读取沙盒数据
//    NSUserDefaults * settings1 = [NSUserDefaults standardUserDefaults];
//    NSString *key1 = [NSString stringWithFormat:@"is_first"];
//    NSString *value = [settings1 objectForKey:key1];
//    if (!value)  //如果没有数据
//    {
//        
//        CGSize screenSize = [UIScreen mainScreen].bounds.size;
//        //我们的scrollView的frame应该是屏幕大小
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
//        //但是我们希望我们scrollView的可被展现区域是4个屏幕横排那么大
//        _scrollView.contentSize = CGSizeMake(screenSize.width * 4, screenSize.height);
//        _scrollView.alwaysBounceHorizontal = YES;//横向一直可拖动
//        _scrollView.pagingEnabled = YES;//关键属性，打开page模式。
//        _scrollView.delegate = self;
//        _scrollView.showsHorizontalScrollIndicator = NO;//不要显示滚动条~
//        [self.view addSubview:_scrollView];
//        
//        for (int i = 0; i < 4; i++) {
//            NSString *imageName = [NSString stringWithFormat:@"裕林医药通启动界面%d.jpg",i+1];
//            UIImage *image = [UIImage imageNamed:imageName];
//            self.navigateImageView = [[UIImageView alloc] initWithImage:image];
//            self.navigateImageView.frame = CGRectMake(i*screenSize.width, 0, screenSize.width, screenSize.height);
//            [_scrollView addSubview:self.navigateImageView];
//        }
//        
//        CGSize size = [self.pageControl sizeForNumberOfPages:4];
//        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//        self.pageControl.center = CGPointMake(screenSize.width/2.0, screenSize.height-50);
//        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
//        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        self.pageControl.numberOfPages = 4;
//        self.pageControl.currentPage = 0;
//        [self.view addSubview:self.pageControl];
//        [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
//        
//        //写入数据
//        NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
//        NSString * key = [NSString stringWithFormat:@"is_first"];
//        [setting setObject:[NSString stringWithFormat:@"false"] forKey:key];
//        [setting synchronize];
//    }
//}

- (void)pageChanged:(UIPageControl*)pageControl{
    //    self.scrollView.contentOffset =   这种方法没有动画
    [self.scrollView setContentOffset:CGPointMake(pageControl.currentPage*SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark --scrollView代理方法

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
//    self.pageControl.currentPage = page;
//    if ((scrollView.contentOffset.x >= 1/4*[UIScreen mainScreen].bounds.size.width)&&(self.pageControl.currentPage == 4)) {
//        RootViewController *rootVC = [[RootViewController alloc] init];
//        [self presentViewController:rootVC animated:YES completion:^{
//            
//        }];
//    }
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/SCREEN_WIDTH;
    self.pageControl.currentPage = page;
}

- (void)pushToStart{
    if (self.pageControl.currentPage == 2) {
        RootTabBarController *rootVC = [[RootTabBarController alloc] init];
        //        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:rootVC];
        //        navC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:rootVC animated:NO completion:nil];
    }

}
@end
