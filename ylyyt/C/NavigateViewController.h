//
//  NavigateViewController.h
//  ylyyt
//
//  Created by apple on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigateViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;//这是基本！

@property (strong, nonatomic) UIImageView *navigateImageView;

@property (strong, nonatomic) UIPageControl *pageControl;

@end
