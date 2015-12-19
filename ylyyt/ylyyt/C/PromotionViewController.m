//
//  PromotionViewController.m
//  ylyyt
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PromotionViewController.h"


@interface PromotionViewController ()

@end

@implementation PromotionViewController

- (void)refreshVC:(NSString *)linkUrl{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:linkUrl]]];
    [self.view addSubview:webView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"促销活动";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


@end
