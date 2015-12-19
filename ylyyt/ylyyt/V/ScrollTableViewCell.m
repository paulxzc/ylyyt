//
//  ScrollTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "ReturnDataItemShow.h"
#import "MedicineImage.h"

@interface ScrollTableViewCell ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *imageViews;

@property (strong, nonatomic) UIPageControl *pageControl;


@end

@implementation ScrollTableViewCell

- (void)refreshCell:(ReturnDataItemShow *)returnDataItemShow{
    NSLog(@"%@",returnDataItemShow);
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < returnDataItemShow.im.count; i++) {
        MedicineImage *medicineImage = returnDataItemShow.im[i];
        [tempArr addObject:medicineImage.imageName];
    }
    
    NSMutableArray *imagesArr = [[NSMutableArray alloc] initWithCapacity:0];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempArr lastObject]]];
    [imagesArr addObject:image];
    
    for (int i = 0; i < tempArr.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@",tempArr[i]];
        UIImage *image = [UIImage imageNamed:imageName];
        [imagesArr addObject:image];
    }
    
    UIImage *imageLast = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempArr firstObject]]];
    [imagesArr addObject:imageLast];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5*SCREEN_HEIGHT)];
    _scrollView.bounces = NO;
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imagesArr.count, 0.5*SCREEN_HEIGHT);
    //    _scrollView.alwaysBounceHorizontal = YES;//横向一直可拖动
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.pagingEnabled = YES;//关键属性，打开page模式。
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;//不要显示滚动条~
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    
    for (int i = 0; i < imagesArr.count; i++) {
        self.imageViews = [[UIImageView alloc] initWithImage:imagesArr[i]];
        self.imageViews.frame = CGRectMake(i*SCREEN_WIDTH,0, SCREEN_WIDTH, 0.5*SCREEN_HEIGHT);
        [_scrollView addSubview:self.imageViews];
    }
    
    CGSize size = [self.pageControl sizeForNumberOfPages:imagesArr.count];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.pageControl.center = CGPointMake(SCREEN_WIDTH/2, 0.5*SCREEN_HEIGHT-10);
    self.pageControl.numberOfPages = imagesArr.count - 2;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    //    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)pageChanged:(UIPageControl*)pageControl{
    [self.scrollView setContentOffset:CGPointMake(pageControl.currentPage*SCREEN_WIDTH, 0) animated:YES];
}

//减速完成时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (currentPage == 0 || currentPage == 5) {
        if (currentPage == 0) {
            currentPage = 4;
        }else{
            currentPage = 1;
        }
        [scrollView setContentOffset:CGPointMake(currentPage*SCREEN_WIDTH, 0)];
    }
    //同步
    _pageControl.currentPage = currentPage-1;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
